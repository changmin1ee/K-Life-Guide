package com.klife.klifeguide.domain.phrase.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.klife.klifeguide.domain.phrase.enums.PhraseCategory;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

public class PhraseResDTO {

    @Getter
    @Builder
    public static class PhraseInfo {
        private Long id;
        private PhraseCategory category;
        private String koText;
        private String enText;
        private String koHint;
        private String enHint;
        private Integer sortOrder;
        @JsonProperty("isSaved")
        private boolean isSaved;
    }

    @Getter
    @Builder
    public static class CategoryPhrasesInfo {
        private PhraseCategory category;
        private String koName;
        private String enName;
        private List<PhraseInfo> phrases;
    }
}
