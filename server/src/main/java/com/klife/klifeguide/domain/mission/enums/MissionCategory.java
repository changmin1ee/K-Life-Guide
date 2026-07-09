package com.klife.klifeguide.domain.mission.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum MissionCategory {
    TRANSPORT("교통", "Transport"),
    FOOD("음식", "Food"),
    ADMIN("행정", "Admin"),
    DAILY("생활", "Daily life"),
    SAFETY("안전", "Safety");

    private final String ko;
    private final String en;
}
