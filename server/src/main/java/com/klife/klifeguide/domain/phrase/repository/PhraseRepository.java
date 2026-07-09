package com.klife.klifeguide.domain.phrase.repository;

import com.klife.klifeguide.domain.phrase.entity.Phrase;
import com.klife.klifeguide.domain.phrase.enums.PhraseCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PhraseRepository extends JpaRepository<Phrase, Long> {

    List<Phrase> findByCategoryOrderBySortOrderAsc(PhraseCategory category);

    List<Phrase> findAllByOrderByCategoryAscSortOrderAsc();
}
