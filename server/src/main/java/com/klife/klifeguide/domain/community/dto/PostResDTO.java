package com.klife.klifeguide.domain.community.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.klife.klifeguide.domain.community.enums.BoardType;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

public class PostResDTO {

    @Getter
    @Builder
    public static class PostSummary {
        private String id;
        private BoardType boardType;
        private String titleKo;
        private String titleEn;
        private String authorName;
        private Integer likeCount;
        private Integer replyCount;
        private Boolean solved;
        private LocalDateTime createdAt;
        @JsonProperty("isLiked")
        private boolean isLiked;
    }

    @Getter
    @Builder
    public static class PostDetail {
        private String id;
        private BoardType boardType;
        private String titleKo;
        private String titleEn;
        private String authorName;
        private Integer likeCount;
        private Integer replyCount;
        private Boolean solved;
        private LocalDateTime createdAt;
        @JsonProperty("isLiked")
        private boolean isLiked;
        private String contentKo;
        private String contentEn;
        private List<ReplyInfo> replies;
    }

    @Getter
    @Builder
    public static class ReplyInfo {
        private String id;
        private String authorName;
        private String authorProfileImageUrl;
        private String content;
        private Integer likeCount;
        private LocalDateTime createdAt;
    }

    @Getter
    @Builder
    public static class LikeResult {
        private String postId;
        private Integer likeCount;
        @JsonProperty("isLiked")
        private boolean isLiked;
    }

    @Getter
    @Builder
    public static class SolveResult {
        private String postId;
        private Boolean solved;
    }
}
