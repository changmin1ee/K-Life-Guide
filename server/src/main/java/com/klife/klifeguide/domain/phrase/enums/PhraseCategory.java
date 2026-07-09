package com.klife.klifeguide.domain.phrase.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum PhraseCategory {
    TAXI("택시", "Taxi"),
    DELIVERY("배달", "Delivery"),
    CLINIC("병원", "Clinic"),
    BANK("은행", "Bank"),
    EMERGENCY("긴급", "Emergency");

    private final String ko;
    private final String en;
}
