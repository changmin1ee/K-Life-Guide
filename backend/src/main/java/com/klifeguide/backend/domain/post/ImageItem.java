package com.klifeguide.backend.domain.post;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ImageItem {

    private String url;
    private int order;

    public ImageItem(String url, int order) {
        this.url = url;
        this.order = order;
    }
}
