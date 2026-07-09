package com.klife.klifeguide.domain.community.dto;

import com.klife.klifeguide.domain.community.enums.BoardType;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;

public class PostReqDTO {

    @Getter
    public static class CreatePost {

        @NotBlank
        private String titleKo;

        private String titleEn;

        @NotBlank
        private String contentKo;

        private String contentEn;

        private BoardType boardType;
    }

    @Getter
    public static class CreateReply {

        @NotBlank
        private String content;
    }
}
