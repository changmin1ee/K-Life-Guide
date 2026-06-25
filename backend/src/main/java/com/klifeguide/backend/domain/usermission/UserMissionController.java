package com.klifeguide.backend.domain.usermission;

import com.klifeguide.backend.domain.usermission.dto.AdminReviewRequest;
import com.klifeguide.backend.domain.usermission.dto.MissionSubmitRequest;
import com.klifeguide.backend.domain.usermission.dto.UserMissionResponse;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserMissionController {

    private final MissionVerificationService missionVerificationService;
    private final UserMissionRepository userMissionRepository;

    public UserMissionController(MissionVerificationService missionVerificationService,
                                  UserMissionRepository userMissionRepository) {
        this.missionVerificationService = missionVerificationService;
        this.userMissionRepository = userMissionRepository;
    }

    @PostMapping("/api/missions/{missionId}/submissions")
    public ResponseEntity<UserMissionResponse> submitMission(
            @AuthenticationPrincipal String userId,
            @PathVariable Long missionId,
            @Valid @RequestBody MissionSubmitRequest request
    ) {
        UserMission userMission = missionVerificationService.submitMission(
                Long.valueOf(userId), missionId, request.photoUrl(), request.latitude(), request.longitude());
        return ResponseEntity.status(HttpStatus.CREATED).body(UserMissionResponse.from(userMission));
    }

    @GetMapping("/api/users/me/missions")
    public ResponseEntity<Page<UserMissionResponse>> getMyMissions(
            @AuthenticationPrincipal String userId,
            Pageable pageable
    ) {
        Page<UserMissionResponse> response = userMissionRepository.findByUserId(Long.valueOf(userId), pageable)
                .map(UserMissionResponse::from);
        return ResponseEntity.ok(response);
    }

    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/api/admin/user-missions/{userMissionId}/review")
    public ResponseEntity<UserMissionResponse> reviewUserMission(
            @AuthenticationPrincipal String adminId,
            @PathVariable Long userMissionId,
            @Valid @RequestBody AdminReviewRequest request
    ) {
        UserMission userMission = missionVerificationService.confirmByAdmin(
                userMissionId, Long.valueOf(adminId), request.approved(), request.reason());
        return ResponseEntity.ok(UserMissionResponse.from(userMission));
    }
}
