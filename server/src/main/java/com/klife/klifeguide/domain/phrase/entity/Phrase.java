package com.klife.klifeguide.domain.phrase.entity;

import com.klife.klifeguide.domain.phrase.enums.PhraseCategory;
import com.klife.klifeguide.global.common.BaseEntity;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "phrase")
@Getter
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Phrase extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PhraseCategory category;

    @Column(nullable = false)
    private String koText;

    @Column(nullable = false)
    private String enText;

    @Column
    private String koHint;

    @Column
    private String enHint;

    @Column(nullable = false)
    private Integer sortOrder;

    @OneToMany(mappedBy = "phrase")
    @Builder.Default
    private List<SavedPhrase> savedPhrases = new ArrayList<>();
}
