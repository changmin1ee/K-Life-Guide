package com.klife.klifeguide.domain.phrase.converter;

import com.klife.klifeguide.domain.phrase.dto.PhraseResDTO;
import com.klife.klifeguide.domain.phrase.entity.Phrase;
import com.klife.klifeguide.domain.phrase.enums.PhraseCategory;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class PhraseConverter {

    public PhraseResDTO.PhraseInfo toPhraseInfo(Phrase phrase, boolean isSaved) {
        return PhraseResDTO.PhraseInfo.builder()
                .id(phrase.getId())
                .category(phrase.getCategory())
                .koText(phrase.getKoText())
                .enText(phrase.getEnText())
                .koHint(phrase.getKoHint())
                .enHint(phrase.getEnHint())
                .sortOrder(phrase.getSortOrder())
                .isSaved(isSaved)
                .build();
    }

    public PhraseResDTO.CategoryPhrasesInfo toCategoryPhrasesInfo(
            PhraseCategory category,
            List<Phrase> phrases,
            Set<Long> savedPhraseIds) {

        List<PhraseResDTO.PhraseInfo> phraseInfos = phrases.stream()
                .map(phrase -> toPhraseInfo(phrase, savedPhraseIds.contains(phrase.getId())))
                .collect(Collectors.toList());

        return PhraseResDTO.CategoryPhrasesInfo.builder()
                .category(category)
                .koName(category.getKo())
                .enName(category.getEn())
                .phrases(phraseInfos)
                .build();
    }
}
