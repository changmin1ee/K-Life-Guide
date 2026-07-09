package com.klife.klifeguide.domain.member.dto;

import com.klife.klifeguide.domain.member.enums.Language;
import lombok.Builder;
import lombok.Getter;

public class MemberResDTO {

    @Getter
    @Builder
    public static class MyProfile {
        private Long id;
        private String name;
        private String email;
        private String profileImageUrl;
        private Integer points;
        private Integer xp;
        private Integer level;
        private Language language;
        private Integer completedMissionCount;
    }

    @Getter
    @Builder
    public static class Summary {
        private Long id;
        private String name;
        private String profileImageUrl;
        private Integer level;
        private Integer points;
        private Integer xp;
    }
}
