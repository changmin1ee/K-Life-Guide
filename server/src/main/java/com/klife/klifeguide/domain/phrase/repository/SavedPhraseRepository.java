package com.klife.klifeguide.domain.phrase.repository;

import com.klife.klifeguide.domain.phrase.entity.SavedPhrase;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SavedPhraseRepository extends JpaRepository<SavedPhrase, Long> {

    Optional<SavedPhrase> findByMemberIdAndPhraseId(Long memberId, Long phraseId);

    List<SavedPhrase> findByMemberId(Long memberId);

    boolean existsByMemberIdAndPhraseId(Long memberId, Long phraseId);

    void deleteByMemberIdAndPhraseId(Long memberId, Long phraseId);
}
