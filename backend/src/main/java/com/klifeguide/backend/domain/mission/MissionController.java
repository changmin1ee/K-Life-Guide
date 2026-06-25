package com.klifeguide.backend.domain.mission;

import com.klifeguide.backend.domain.mission.dto.CreateMissionRequest;
import com.klifeguide.backend.domain.mission.dto.MissionResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/missions")
public class MissionController {

    private final MissionService missionService;

    public MissionController(MissionService missionService) {
        this.missionService = missionService;
    }

    @GetMapping
    public ResponseEntity<Page<MissionResponse>> getMissions(
            @RequestParam(required = false) Long categoryId,
            Pageable pageable
    ) {
        return ResponseEntity.ok(missionService.getMissions(categoryId, pageable));
    }

    @GetMapping("/{missionId}")
    public ResponseEntity<MissionResponse> getMission(@PathVariable Long missionId) {
        return ResponseEntity.ok(missionService.getMission(missionId));
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping
    public ResponseEntity<MissionResponse> createMission(
            @AuthenticationPrincipal String adminId,
            @Valid @RequestBody CreateMissionRequest request
    ) {
        MissionResponse response = missionService.createMission(Long.valueOf(adminId), request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}
