package com.klifeguide.backend.global.gemini;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.klifeguide.backend.global.exception.BusinessException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

import java.math.BigDecimal;
import java.util.Base64;
import java.util.List;
import java.util.Locale;

@Component
public class GeminiVerificationClient {

    private static final String VERIFICATION_PROMPT_TEMPLATE = """
            너는 미션 인증 사진을 검증하는 심사관이다.
            아래 미션을 사용자가 실제로 수행했다는 근거가 사진에 있는지 평가하라.

            미션 제목: %s
            미션 설명: %s

            반드시 아래 JSON 형식으로만 응답하라:
            {"confidence": 0~100 사이의 숫자, "isValid": true/false, "reason": "판단 근거 한국어로 한 문장"}
            """;

    private final RestClient geminiApiClient;
    private final RestClient downloadClient;
    private final ObjectMapper objectMapper;
    private final String apiKey;
    private final String model;

    public GeminiVerificationClient(
            ObjectMapper objectMapper,
            @Value("${gemini.base-url}") String baseUrl,
            @Value("${gemini.api-key}") String apiKey,
            @Value("${gemini.model}") String model
    ) {
        this.objectMapper = objectMapper;
        this.geminiApiClient = RestClient.builder().baseUrl(baseUrl).build();
        this.downloadClient = RestClient.create();
        this.apiKey = apiKey;
        this.model = model;
    }

    public GeminiAnalysisResult verifyMissionPhoto(String photoUrl, String missionTitle, String missionDescription) {
        byte[] imageBytes = downloadClient.get()
                .uri(photoUrl)
                .retrieve()
                .body(byte[].class);

        if (imageBytes == null) {
            throw new BusinessException(HttpStatus.BAD_GATEWAY, "PHOTO_DOWNLOAD_FAILED", "인증 사진을 가져올 수 없습니다.");
        }

        String prompt = VERIFICATION_PROMPT_TEMPLATE.formatted(missionTitle, missionDescription);
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);

        GeminiApiDto.GenerateContentRequest request = new GeminiApiDto.GenerateContentRequest(
                List.of(new GeminiApiDto.Content(List.of(
                        GeminiApiDto.Part.ofText(prompt),
                        GeminiApiDto.Part.ofImage(resolveMimeType(photoUrl), base64Image)
                ))),
                new GeminiApiDto.GenerationConfig("application/json")
        );

        GeminiApiDto.GenerateContentResponse response = geminiApiClient.post()
                .uri("/v1beta/models/{model}:generateContent?key={apiKey}", model, apiKey)
                .body(request)
                .retrieve()
                .body(GeminiApiDto.GenerateContentResponse.class);

        String rawJson = extractText(response);
        GeminiApiDto.VerificationPayload payload = parsePayload(rawJson);

        return new GeminiAnalysisResult(payload.confidence(), payload.isValid(), payload.reason(), rawJson);
    }

    private String extractText(GeminiApiDto.GenerateContentResponse response) {
        if (response == null || response.candidates() == null || response.candidates().isEmpty()) {
            throw new BusinessException(HttpStatus.BAD_GATEWAY, "GEMINI_EMPTY_RESPONSE", "Gemini 응답이 비어 있습니다.");
        }
        return response.candidates().get(0).content().parts().get(0).text();
    }

    private GeminiApiDto.VerificationPayload parsePayload(String rawJson) {
        try {
            return objectMapper.readValue(rawJson, GeminiApiDto.VerificationPayload.class);
        } catch (Exception e) {
            throw new BusinessException(HttpStatus.BAD_GATEWAY, "GEMINI_PARSE_FAILED", "Gemini 응답 파싱에 실패했습니다.");
        }
    }

    private String resolveMimeType(String photoUrl) {
        String lower = photoUrl.toLowerCase(Locale.ROOT);
        if (lower.endsWith(".png")) {
            return "image/png";
        }
        if (lower.endsWith(".webp")) {
            return "image/webp";
        }
        return "image/jpeg";
    }
}
