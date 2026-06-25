package com.klifeguide.backend.domain.usermission;

import com.klifeguide.backend.domain.adminreview.AdminReview;
import com.klifeguide.backend.domain.adminreview.AdminReviewRepository;
import com.klifeguide.backend.domain.adminreview.ReviewDecision;
import com.klifeguide.backend.domain.mission.Mission;
import com.klifeguide.backend.domain.mission.MissionRepository;
import com.klifeguide.backend.domain.user.User;
import com.klifeguide.backend.domain.user.UserRepository;
import com.klifeguide.backend.global.exception.BusinessException;
import com.klifeguide.backend.global.gemini.GeminiAnalysisResult;
import com.klifeguide.backend.global.gemini.GeminiVerificationClient;
import com.klifeguide.backend.global.util.GeoUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@Transactional(readOnly = true)
public class MissionVerificationService {

    private static final List<UserMissionStatus> ALREADY_DONE_STATUSES =
            List.of(UserMissionStatus.APPROVED, UserMissionStatus.AI_APPROVED);

    private final UserMissionRepository userMissionRepository;
    private final MissionRepository missionRepository;
    private final UserRepository userRepository;
    private final AdminReviewRepository adminReviewRepository;
    private final GeminiVerificationClient geminiVerificationClient;
    private final BigDecimal autoApproveThreshold;
    private final BigDecimal autoRejectThreshold;

    public MissionVerificationService(
            UserMissionRepository userMissionRepository,
            MissionRepository missionRepository,
            UserRepository userRepository,
            AdminReviewRepository adminReviewRepository,
            GeminiVerificationClient geminiVerificationClient,
            @Value("${mission.verification.auto-approve-confidence-threshold}") BigDecimal autoApproveThreshold,
            @Value("${mission.verification.auto-reject-confidence-threshold}") BigDecimal autoRejectThreshold
    ) {
        this.userMissionRepository = userMissionRepository;
        this.missionRepository = missionRepository;
        this.userRepository = userRepository;
        this.adminReviewRepository = adminReviewRepository;
        this.geminiVerificationClient = geminiVerificationClient;
        this.autoApproveThreshold = autoApproveThreshold;
        this.autoRejectThreshold = autoRejectThreshold;
    }

    @Transactional
    public UserMission submitMission(Long userId, Long missionId, String photoUrl,
                                       BigDecimal latitude, BigDecimal longitude) {
        User user = getUser(userId);
        Mission mission = getMission(missionId);

        if (userMissionRepository.existsByUserIdAndMissionIdAndStatusIn(userId, missionId, ALREADY_DONE_STATUSES)) {
            throw new BusinessException(HttpStatus.CONFLICT, "MISSION_ALREADY_COMPLETED", "이미 완료한 미션입니다.");
        }

        int attemptNo = userMissionRepository.findTopByUserIdAndMissionIdOrderByAttemptNoDesc(userId, missionId)
                .map(previous -> previous.getAttemptNo() + 1)
                .orElse(1);

        UserMission userMission = UserMission.builder()
                .user(user)
                .mission(mission)
                .attemptNo(attemptNo)
                .photoUrl(photoUrl)
                .submittedLatitude(latitude)
                .submittedLongitude(longitude)
                .build();

        BigDecimal distance = GeoUtils.distanceMeters(
                mission.getLatitude(), mission.getLongitude(), latitude, longitude);
        boolean gpsVerified = distance.compareTo(BigDecimal.valueOf(mission.getRadiusMeters())) <= 0;
        userMission.applyGpsResult(distance, gpsVerified);

        GeminiAnalysisResult analysisResult = geminiVerificationClient.verifyMissionPhoto(
                photoUrl, mission.getTitle(), mission.getDescription());
        userMission.applyGeminiResult(analysisResult.confidenceScore(), analysisResult.rawResponseJson());

        decideVerificationResult(userMission, mission, user, analysisResult);

        return userMissionRepository.save(userMission);
    }

    private void decideVerificationResult(UserMission userMission, Mission mission, User user,
                                            GeminiAnalysisResult analysisResult) {
        boolean gpsVerified = userMission.isGpsVerified();
        BigDecimal confidence = analysisResult.confidenceScore();

        if (gpsVerified && analysisResult.valid() && confidence.compareTo(autoApproveThreshold) >= 0) {
            userMission.autoApprove(mission.getPoints());
            user.earnPoints(mission.getPoints());
            return;
        }

        if (!gpsVerified || !analysisResult.valid() || confidence.compareTo(autoRejectThreshold) < 0) {
            userMission.rejectByAi();
            return;
        }

        userMission.escalateToAdminReview();
    }

    @Transactional
    public UserMission confirmByAdmin(Long userMissionId, Long adminId, boolean approved, String reason) {
        UserMission userMission = userMissionRepository.findById(userMissionId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "USER_MISSION_NOT_FOUND", "미션 인증 내역을 찾을 수 없습니다."));
        User admin = getUser(adminId);

        if (userMission.getStatus() != UserMissionStatus.NEEDS_ADMIN_REVIEW) {
            throw new BusinessException(HttpStatus.CONFLICT, "NOT_PENDING_ADMIN_REVIEW", "관리자 검수 대상이 아닙니다.");
        }

        Mission mission = userMission.getMission();
        userMission.confirmByAdmin(approved, mission.getPoints());
        if (approved) {
            userMission.getUser().earnPoints(mission.getPoints());
        }

        AdminReview adminReview = AdminReview.builder()
                .userMission(userMission)
                .admin(admin)
                .decision(approved ? ReviewDecision.APPROVED : ReviewDecision.REJECTED)
                .reason(reason)
                .build();
        adminReviewRepository.save(adminReview);

        return userMission;
    }

    private User getUser(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "USER_NOT_FOUND", "사용자를 찾을 수 없습니다."));
    }

    private Mission getMission(Long missionId) {
        return missionRepository.findById(missionId)
                .orElseThrow(() -> new BusinessException(HttpStatus.NOT_FOUND, "MISSION_NOT_FOUND", "미션을 찾을 수 없습니다."));
    }
}
