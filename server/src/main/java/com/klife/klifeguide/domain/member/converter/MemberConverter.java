package com.klife.klifeguide.domain.member.converter;

import com.klife.klifeguide.domain.member.dto.MemberResDTO;
import com.klife.klifeguide.domain.member.entity.Member;
import org.springframework.stereotype.Component;

@Component
public class MemberConverter {

    public MemberResDTO.MyProfile toMyProfile(Member member, int completedMissionCount) {
        return MemberResDTO.MyProfile.builder()
                .id(member.getId())
                .name(member.getName())
                .email(member.getEmail())
                .profileImageUrl(member.getProfileImageUrl())
                .points(member.getPoints())
                .xp(member.getXp())
                .level(member.getLevel())
                .language(member.getLanguage())
                .completedMissionCount(completedMissionCount)
                .build();
    }

    public MemberResDTO.Summary toSummary(Member member) {
        return MemberResDTO.Summary.builder()
                .id(member.getId())
                .name(member.getName())
                .profileImageUrl(member.getProfileImageUrl())
                .level(member.getLevel())
                .points(member.getPoints())
                .xp(member.getXp())
                .build();
    }
}
