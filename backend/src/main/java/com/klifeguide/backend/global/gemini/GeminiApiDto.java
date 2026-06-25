package com.klifeguide.backend.global.gemini;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

public class GeminiApiDto {

    public record GenerateContentRequest(List<Content> contents, GenerationConfig generationConfig) {
    }

    public record GenerationConfig(String responseMimeType) {
    }

    public record Content(List<Part> parts) {
    }

    @JsonInclude(JsonInclude.Include.NON_NULL)
    public record Part(String text, InlineData inlineData) {

        public static Part ofText(String text) {
            return new Part(text, null);
        }

        public static Part ofImage(String mimeType, String base64Data) {
            return new Part(null, new InlineData(mimeType, base64Data));
        }
    }

    public record InlineData(String mimeType, String data) {
    }

    public record GenerateContentResponse(List<Candidate> candidates) {
    }

    public record Candidate(Content content) {
    }

    public record VerificationPayload(java.math.BigDecimal confidence, boolean isValid, String reason) {
    }

    private GeminiApiDto() {
    }
}
