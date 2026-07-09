package com.klife.klifeguide.domain.member.dto;

import com.klife.klifeguide.domain.member.enums.Language;
import lombok.Getter;
import lombok.NoArgsConstructor;

public class MemberReqDTO {

    @Getter
    @NoArgsConstructor
    public static class UpdateLanguage {
        private Language language;
    }
}
