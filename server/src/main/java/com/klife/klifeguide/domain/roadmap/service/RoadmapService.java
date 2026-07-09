package com.klife.klifeguide.domain.roadmap.service;

import com.klife.klifeguide.domain.roadmap.converter.RoadmapConverter;
import com.klife.klifeguide.domain.roadmap.dto.RoadmapResDTO;
import com.klife.klifeguide.domain.roadmap.entity.RoadmapItem;
import com.klife.klifeguide.domain.roadmap.entity.UserRoadmap;
import com.klife.klifeguide.domain.roadmap.exception.RoadmapException;
import com.klife.klifeguide.domain.roadmap.exception.code.RoadmapErrorCode;
import com.klife.klifeguide.domain.roadmap.repository.RoadmapItemRepository;
import com.klife.klifeguide.domain.roadmap.repository.UserRoadmapRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class RoadmapService {

    private final RoadmapItemRepository roadmapItemRepository;
    private final UserRoadmapRepository userRoadmapRepository;
    private final RoadmapConverter roadmapConverter;

    public RoadmapResDTO.RoadmapProgress getRoadmap(Long memberId) {
        List<RoadmapItem> allItems = getAllRoadmapItems();

        Map<Long, UserRoadmap> userRoadmapMap = userRoadmapRepository
                .findByMemberIdOrderByRoadmapItemSortOrderAsc(memberId)
                .stream()
                .collect(Collectors.toMap(ur -> ur.getRoadmapItem().getId(), ur -> ur));

        List<RoadmapResDTO.RoadmapItemInfo> itemInfos = allItems.stream()
                .map(item -> {
                    UserRoadmap userRoadmap = userRoadmapMap.get(item.getId());
                    if (userRoadmap != null) {
                        return roadmapConverter.toRoadmapItemInfo(userRoadmap);
                    } else {
                        return roadmapConverter.toRoadmapItemInfo(item, false, null);
                    }
                })
                .collect(Collectors.toList());

        return roadmapConverter.toRoadmapProgress(itemInfos);
    }

    /**
     * RoadmapItem 전체 목록 캐시 (TTL 6시간)
     * 정적 데이터로 자주 변경되지 않으므로 긴 TTL 적용
     */
    @Cacheable(value = "roadmapItems", key = "'all'")
    public List<RoadmapItem> getAllRoadmapItems() {
        return roadmapItemRepository.findAllByOrderBySortOrderAsc();
    }

    @Transactional
    public RoadmapResDTO.RoadmapItemInfo toggleRoadmapItem(Long memberId, Long itemId) {
        RoadmapItem roadmapItem = roadmapItemRepository.findById(itemId)
                .orElseThrow(() -> new RoadmapException(RoadmapErrorCode.ROADMAP_ITEM_NOT_FOUND));

        Optional<UserRoadmap> existing = userRoadmapRepository.findByMemberIdAndRoadmapItemId(memberId, itemId);

        if (existing.isEmpty()) {
            UserRoadmap newUserRoadmap = UserRoadmap.builder()
                    .memberId(memberId)
                    .roadmapItem(roadmapItem)
                    .done(true)
                    .build();
            newUserRoadmap.markDone();
            UserRoadmap saved = userRoadmapRepository.save(newUserRoadmap);
            return roadmapConverter.toRoadmapItemInfo(saved);
        } else {
            UserRoadmap userRoadmap = existing.get();
            if (userRoadmap.getDone()) {
                userRoadmap.markUndone();
            } else {
                userRoadmap.markDone();
            }
            return roadmapConverter.toRoadmapItemInfo(userRoadmap);
        }
    }
}
