package com.klife.klifeguide.domain.phrase.service;

import com.klife.klifeguide.domain.phrase.converter.PhraseConverter;
import com.klife.klifeguide.domain.phrase.dto.PhraseResDTO;
import com.klife.klifeguide.domain.phrase.entity.Phrase;
import com.klife.klifeguide.domain.phrase.entity.SavedPhrase;
import com.klife.klifeguide.domain.phrase.enums.PhraseCategory;
import com.klife.klifeguide.domain.phrase.exception.PhraseException;
import com.klife.klifeguide.domain.phrase.exception.code.PhraseErrorCode;
import com.klife.klifeguide.domain.phrase.repository.PhraseRepository;
import com.klife.klifeguide.domain.phrase.repository.SavedPhraseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PhraseService {

    private final PhraseRepository phraseRepository;
    private final SavedPhraseRepository savedPhraseRepository;
    private final PhraseConverter phraseConverter;

    public List<PhraseResDTO.PhraseInfo> getPhrasesByCategory(PhraseCategory category, Long memberId) {
        List<Phrase> phrases = phraseRepository.findByCategoryOrderBySortOrderAsc(category);
        Set<Long> savedIds = getSavedPhraseIds(memberId);

        return phrases.stream()
                .map(phrase -> phraseConverter.toPhraseInfo(phrase, savedIds.contains(phrase.getId())))
                .collect(Collectors.toList());
    }

    /**
     * 전체 표현 목록 조회
     * 비로그인(memberId=null)인 게스트 케이스만 캐시 적용 (TTL 1시간)
     */
    @Cacheable(value = "phrases", key = "'all'", condition = "#memberId == null")
    public List<PhraseResDTO.CategoryPhrasesInfo> getAllPhrases(Long memberId) {
        List<Phrase> allPhrases = phraseRepository.findAllByOrderByCategoryAscSortOrderAsc();
        Set<Long> savedIds = getSavedPhraseIds(memberId);

        Map<PhraseCategory, List<Phrase>> groupedByCategory = allPhrases.stream()
                .collect(Collectors.groupingBy(Phrase::getCategory));

        return Arrays.stream(PhraseCategory.values())
                .filter(groupedByCategory::containsKey)
                .map(category -> phraseConverter.toCategoryPhrasesInfo(
                        category,
                        groupedByCategory.get(category),
                        savedIds))
                .collect(Collectors.toList());
    }

    /**
     * 표현 저장 — phrases 캐시 전체 무효화
     */
    @Transactional
    @CacheEvict(value = "phrases", allEntries = true)
    public PhraseResDTO.PhraseInfo savePhrase(Long memberId, Long phraseId) {
        Phrase phrase = phraseRepository.findById(phraseId)
                .orElseThrow(() -> new PhraseException(PhraseErrorCode.PHRASE_NOT_FOUND));

        if (savedPhraseRepository.existsByMemberIdAndPhraseId(memberId, phraseId)) {
            throw new PhraseException(PhraseErrorCode.ALREADY_SAVED);
        }

        SavedPhrase savedPhrase = SavedPhrase.builder()
                .memberId(memberId)
                .phrase(phrase)
                .build();
        savedPhraseRepository.save(savedPhrase);

        return phraseConverter.toPhraseInfo(phrase, true);
    }

    /**
     * 표현 저장 취소 — phrases 캐시 전체 무효화
     */
    @Transactional
    @CacheEvict(value = "phrases", allEntries = true)
    public void unsavePhrase(Long memberId, Long phraseId) {
        phraseRepository.findById(phraseId)
                .orElseThrow(() -> new PhraseException(PhraseErrorCode.PHRASE_NOT_FOUND));

        if (!savedPhraseRepository.existsByMemberIdAndPhraseId(memberId, phraseId)) {
            throw new PhraseException(PhraseErrorCode.NOT_SAVED);
        }

        savedPhraseRepository.deleteByMemberIdAndPhraseId(memberId, phraseId);
    }

    public List<PhraseResDTO.PhraseInfo> getSavedPhrases(Long memberId) {
        List<SavedPhrase> savedPhrases = savedPhraseRepository.findByMemberId(memberId);

        return savedPhrases.stream()
                .map(sp -> phraseConverter.toPhraseInfo(sp.getPhrase(), true))
                .collect(Collectors.toList());
    }

    private Set<Long> getSavedPhraseIds(Long memberId) {
        if (memberId == null) {
            return Set.of();
        }
        return savedPhraseRepository.findByMemberId(memberId).stream()
                .map(sp -> sp.getPhrase().getId())
                .collect(Collectors.toSet());
    }
}
