package com.klife.klifeguide.domain.member.service;

import com.klife.klifeguide.domain.member.converter.MemberConverter;
import com.klife.klifeguide.domain.member.dto.MemberResDTO;
import com.klife.klifeguide.domain.member.entity.Member;
import com.klife.klifeguide.domain.member.enums.Language;
import com.klife.klifeguide.domain.member.exception.MemberException;
import com.klife.klifeguide.domain.member.exception.code.MemberErrorCode;
import com.klife.klifeguide.domain.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MemberService {

    private final MemberRepository memberRepository;
    private final MemberConverter memberConverter;

    public MemberResDTO.MyProfile getMyProfile(Long memberId) {
        Member member = findById(memberId);
        // completedMissionCount는 추후 MemberMissionRepository 연동 시 교체
        return memberConverter.toMyProfile(member, 0);
    }

    @Transactional
    public MemberResDTO.MyProfile updateLanguage(Long memberId, Language language) {
        Member member = findById(memberId);
        member.updateLanguage(language);
        return memberConverter.toMyProfile(member, 0);
    }

    public Member findById(Long memberId) {
        return memberRepository.findById(memberId)
                .orElseThrow(() -> new MemberException(MemberErrorCode.MEMBER_NOT_FOUND));
    }

    @Transactional
    public Member findOrCreate(String email, String name, String providerId, String profileImageUrl) {
        return memberRepository.findByProviderId(providerId)
                .orElseGet(() -> memberRepository.save(
                        Member.builder()
                                .email(email)
                                .name(name)
                                .providerId(providerId)
                                .profileImageUrl(profileImageUrl)
                                .build()
                ));
    }
}
