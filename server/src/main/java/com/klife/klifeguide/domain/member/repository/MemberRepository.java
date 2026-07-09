package com.klife.klifeguide.domain.member.repository;

import com.klife.klifeguide.domain.member.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface MemberRepository extends JpaRepository<Member, Long> {

    Optional<Member> findByEmail(String email);

    Optional<Member> findByProviderId(String providerId);

    boolean existsByEmail(String email);
}
