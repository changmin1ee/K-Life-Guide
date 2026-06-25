package com.klifeguide.backend.domain.mission.dto;

import java.util.List;

public record CachedMissionPage(List<MissionResponse> content, long totalElements) {
}
