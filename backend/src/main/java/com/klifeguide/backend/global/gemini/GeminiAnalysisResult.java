package com.klifeguide.backend.global.gemini;

import java.math.BigDecimal;

public record GeminiAnalysisResult(
        BigDecimal confidenceScore,
        boolean valid,
        String reason,
        String rawResponseJson
) {
}
