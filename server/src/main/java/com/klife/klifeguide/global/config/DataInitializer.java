package com.klife.klifeguide.global.config;

import com.klife.klifeguide.domain.community.repository.PostRepository;
import com.klife.klifeguide.domain.community.repository.ReplyRepository;
import com.klife.klifeguide.domain.mission.entity.Mission;
import com.klife.klifeguide.domain.mission.enums.MissionType;
import com.klife.klifeguide.domain.mission.repository.MissionRepository;
import com.klife.klifeguide.domain.phrase.entity.Phrase;
import com.klife.klifeguide.domain.phrase.enums.PhraseCategory;
import com.klife.klifeguide.domain.phrase.repository.PhraseRepository;
import com.klife.klifeguide.domain.roadmap.entity.RoadmapItem;
import com.klife.klifeguide.domain.roadmap.repository.RoadmapItemRepository;
import com.klife.klifeguide.domain.reward.entity.Badge;
import com.klife.klifeguide.domain.reward.repository.BadgeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements ApplicationRunner {

    private final MissionRepository missionRepository;
    private final PhraseRepository phraseRepository;
    private final RoadmapItemRepository roadmapItemRepository;
    private final BadgeRepository badgeRepository;
    private final PostRepository postRepository;
    private final ReplyRepository replyRepository;

    @Value("${spring.jpa.hibernate.ddl-auto:none}")
    private String ddlAuto;

    @Override
    public void run(ApplicationArguments args) {
        // JPA가 create 모드일 때 MongoDB 컬렉션도 초기화 (구버전 도큐먼트 역직렬화 오류 방지)
        // MongoDB는 JPA 트랜잭션과 무관하므로 @Transactional 없이 직접 호출
        if ("create".equals(ddlAuto)) {
            try {
                log.info("[DataInitializer] ddl-auto=create → clearing MongoDB collections (posts, replies)");
                postRepository.deleteAll();
                replyRepository.deleteAll();
                log.info("[DataInitializer] MongoDB collections cleared.");
            } catch (Exception e) {
                log.warn("[DataInitializer] MongoDB cleanup skipped: {}", e.getMessage());
            }
        }
        seedData();
    }

    @Transactional
    public void seedData() {
        seedMissions();
        seedPhrases();
        seedRoadmap();
        seedBadges();
    }

    private void seedMissions() {
        if (missionRepository.count() > 0) return;
        log.info("[DataInitializer] Seeding missions...");

        List<Mission> missions = List.of(
            Mission.builder().type(MissionType.GUIDE).koCategory("교통").enCategory("Transport")
                .koTitle("지하철 노선 확인하기").enTitle("Check Subway Routes")
                .koDesc("한국 지하철 앱으로 목적지까지 경로를 검색해보세요.")
                .enDesc("Search for routes using a Korean subway app.")
                .xp(30).point(100).sortOrder(1).build(),
            Mission.builder().type(MissionType.GUIDE).koCategory("교통").enCategory("Transport")
                .koTitle("교통카드 충전하기").enTitle("Charge T-money Card")
                .koDesc("편의점이나 지하철역에서 교통카드를 충전해보세요.")
                .enDesc("Charge your T-money card at a convenience store or subway station.")
                .xp(20).point(80).sortOrder(2).build(),
            Mission.builder().type(MissionType.VERIFY).koCategory("음식").enCategory("Food")
                .koTitle("배달 앱으로 주문하기").enTitle("Order via Delivery App")
                .koDesc("배민이나 쿠팡이츠로 첫 배달 주문을 해보세요.")
                .enDesc("Place your first delivery order via Baemin or Coupang Eats.")
                .xp(40).point(150).sortOrder(3).build(),
            Mission.builder().type(MissionType.GUIDE).koCategory("음식").enCategory("Food")
                .koTitle("편의점에서 상품 구매하기").enTitle("Buy at Convenience Store")
                .koDesc("GS25, CU, 세븐일레븐 등 편의점에서 물건을 구매해보세요.")
                .enDesc("Buy something at GS25, CU, or 7-Eleven.")
                .xp(20).point(60).sortOrder(4).build(),
            Mission.builder().type(MissionType.VERIFY).koCategory("행정").enCategory("Admin")
                .koTitle("외국인 등록증 신청하기").enTitle("Apply for Alien Registration")
                .koDesc("입국 후 90일 이내에 외국인 등록증을 신청하세요.")
                .enDesc("Apply for your Alien Registration Card within 90 days of entry.")
                .xp(100).point(500).sortOrder(5).build(),
            Mission.builder().type(MissionType.GUIDE).koCategory("행정").enCategory("Admin")
                .koTitle("주민센터 위치 파악하기").enTitle("Find Local Community Center")
                .koDesc("거주 지역 주민센터 위치와 운영 시간을 확인해보세요.")
                .enDesc("Find your local community center's location and hours.")
                .xp(20).point(50).sortOrder(6).build(),
            Mission.builder().type(MissionType.GUIDE).koCategory("생활").enCategory("Daily")
                .koTitle("분리수거 방법 익히기").enTitle("Learn Recycling Rules")
                .koDesc("한국의 분리수거 규칙을 익혀보세요. 종류별로 분리해야 합니다.")
                .enDesc("Learn Korean recycling rules. Items must be sorted by type.")
                .xp(30).point(80).sortOrder(7).build(),
            Mission.builder().type(MissionType.VERIFY).koCategory("생활").enCategory("Daily")
                .koTitle("은행 계좌 개설하기").enTitle("Open a Bank Account")
                .koDesc("카카오뱅크나 시중 은행에서 계좌를 개설해보세요.")
                .enDesc("Open an account at KakaoBank or a major bank.")
                .xp(80).point(300).sortOrder(8).build(),
            Mission.builder().type(MissionType.GUIDE).koCategory("안전").enCategory("Safety")
                .koTitle("긴급 연락처 저장하기").enTitle("Save Emergency Contacts")
                .koDesc("119(소방·구급), 112(경찰), 1345(외국인 종합안내) 저장하세요.")
                .enDesc("Save 119 (fire/EMS), 112 (police), 1345 (foreigner helpline).")
                .xp(20).point(50).sortOrder(9).build(),
            Mission.builder().type(MissionType.VERIFY).koCategory("안전").enCategory("Safety")
                .koTitle("의료보험 가입 확인하기").enTitle("Check Health Insurance")
                .koDesc("국민건강보험 가입 여부와 병원 이용 방법을 확인해보세요.")
                .enDesc("Check your national health insurance status and how to use hospitals.")
                .xp(60).point(200).sortOrder(10).build()
        );
        missionRepository.saveAll(missions);
        log.info("[DataInitializer] {} missions seeded.", missions.size());
    }

    private void seedPhrases() {
        if (phraseRepository.count() > 0) return;
        log.info("[DataInitializer] Seeding phrases...");

        // TAXI
        phraseRepository.saveAll(List.of(
            Phrase.builder().category(PhraseCategory.TAXI)
                .koText("어디로 가세요?").enText("Where are you going?")
                .koHint(null).enHint(null).sortOrder(1).build(),
            Phrase.builder().category(PhraseCategory.TAXI)
                .koText("여기서 세워주세요.").enText("Stop here, please.")
                .koHint("목적지 근처에서 사용").enHint("Use near destination").sortOrder(2).build(),
            Phrase.builder().category(PhraseCategory.TAXI)
                .koText("미터기로 가주세요.").enText("Please use the meter.")
                .koHint(null).enHint(null).sortOrder(3).build(),
            Phrase.builder().category(PhraseCategory.TAXI)
                .koText("영수증 주세요.").enText("Please give me a receipt.")
                .koHint(null).enHint(null).sortOrder(4).build()
        ));

        // DELIVERY
        phraseRepository.saveAll(List.of(
            Phrase.builder().category(PhraseCategory.DELIVERY)
                .koText("문 앞에 놔주세요.").enText("Please leave it at the door.")
                .koHint("비대면 배달 시").enHint("For contactless delivery").sortOrder(1).build(),
            Phrase.builder().category(PhraseCategory.DELIVERY)
                .koText("주문이 언제 도착하나요?").enText("When will my order arrive?")
                .koHint(null).enHint(null).sortOrder(2).build(),
            Phrase.builder().category(PhraseCategory.DELIVERY)
                .koText("빠진 메뉴가 있어요.").enText("There's a missing item.")
                .koHint(null).enHint(null).sortOrder(3).build()
        ));

        // CLINIC
        phraseRepository.saveAll(List.of(
            Phrase.builder().category(PhraseCategory.CLINIC)
                .koText("진료 예약하고 싶어요.").enText("I'd like to make an appointment.")
                .koHint(null).enHint(null).sortOrder(1).build(),
            Phrase.builder().category(PhraseCategory.CLINIC)
                .koText("여기가 아파요.").enText("It hurts here.")
                .koHint("아픈 부위 가리키며").enHint("Point to the area").sortOrder(2).build(),
            Phrase.builder().category(PhraseCategory.CLINIC)
                .koText("처방전 주세요.").enText("Please give me a prescription.")
                .koHint(null).enHint(null).sortOrder(3).build(),
            Phrase.builder().category(PhraseCategory.CLINIC)
                .koText("보험 적용 되나요?").enText("Is this covered by insurance?")
                .koHint(null).enHint(null).sortOrder(4).build()
        ));

        // BANK
        phraseRepository.saveAll(List.of(
            Phrase.builder().category(PhraseCategory.BANK)
                .koText("계좌 개설하고 싶어요.").enText("I'd like to open an account.")
                .koHint(null).enHint(null).sortOrder(1).build(),
            Phrase.builder().category(PhraseCategory.BANK)
                .koText("송금하고 싶어요.").enText("I'd like to transfer money.")
                .koHint(null).enHint(null).sortOrder(2).build(),
            Phrase.builder().category(PhraseCategory.BANK)
                .koText("비밀번호를 잊어버렸어요.").enText("I forgot my password.")
                .koHint(null).enHint(null).sortOrder(3).build()
        ));

        // EMERGENCY
        phraseRepository.saveAll(List.of(
            Phrase.builder().category(PhraseCategory.EMERGENCY)
                .koText("도와주세요!").enText("Help me!")
                .koHint("긴급 상황").enHint("Emergency").sortOrder(1).build(),
            Phrase.builder().category(PhraseCategory.EMERGENCY)
                .koText("119에 전화해주세요.").enText("Please call 119.")
                .koHint("구급차 필요 시").enHint("When ambulance needed").sortOrder(2).build(),
            Phrase.builder().category(PhraseCategory.EMERGENCY)
                .koText("경찰 불러주세요.").enText("Please call the police.")
                .koHint(null).enHint(null).sortOrder(3).build(),
            Phrase.builder().category(PhraseCategory.EMERGENCY)
                .koText("한국어를 못해요.").enText("I can't speak Korean.")
                .koHint(null).enHint(null).sortOrder(4).build()
        ));

        log.info("[DataInitializer] Phrases seeded.");
    }

    private void seedRoadmap() {
        if (roadmapItemRepository.count() > 0) return;
        log.info("[DataInitializer] Seeding roadmap...");

        List<RoadmapItem> items = List.of(
            RoadmapItem.builder().dayNumber(1).sortOrder(1).iconKey("sim")
                .koTitle("유심 개통하기").enTitle("Activate SIM Card")
                .koDesc("공항 또는 편의점에서 유심을 구매하고 개통하세요.")
                .enDesc("Buy and activate a SIM card at the airport or convenience store.").build(),
            RoadmapItem.builder().dayNumber(1).sortOrder(2).iconKey("transport")
                .koTitle("교통카드 구매하기").enTitle("Buy T-money Card")
                .koDesc("지하철역이나 편의점에서 T-money 카드를 구매하세요.")
                .enDesc("Buy a T-money card at a subway station or convenience store.").build(),
            RoadmapItem.builder().dayNumber(2).sortOrder(3).iconKey("location")
                .koTitle("주민센터에서 전입신고").enTitle("Register Address at Community Center")
                .koDesc("거주지 근처 주민센터에서 전입신고를 완료하세요.")
                .enDesc("Complete your address registration at the local community center.").build(),
            RoadmapItem.builder().dayNumber(3).sortOrder(4).iconKey("food")
                .koTitle("배달 앱 설치하기").enTitle("Install Delivery App")
                .koDesc("배달의민족 또는 쿠팡이츠를 설치하고 첫 주문을 해보세요.")
                .enDesc("Install Baemin or Coupang Eats and place your first order.").build(),
            RoadmapItem.builder().dayNumber(4).sortOrder(5).iconKey("admin")
                .koTitle("외국인 등록증 신청").enTitle("Apply for Alien Registration Card")
                .koDesc("출입국·외국인청에 방문하여 외국인 등록증을 신청하세요.")
                .enDesc("Visit the immigration office to apply for your Alien Registration Card.").build(),
            RoadmapItem.builder().dayNumber(5).sortOrder(6).iconKey("safety")
                .koTitle("긴급 연락처 저장").enTitle("Save Emergency Numbers")
                .koDesc("119, 112, 1345를 연락처에 저장해두세요.")
                .enDesc("Save 119, 112, and 1345 in your contacts.").build()
        );
        roadmapItemRepository.saveAll(items);
        log.info("[DataInitializer] {} roadmap items seeded.", items.size());
    }

    private void seedBadges() {
        if (badgeRepository.count() > 0) return;
        log.info("[DataInitializer] Seeding badges...");

        List<Badge> badges = List.of(
            Badge.builder().koName("교통 마스터").enName("Transit Master")
                .koDesc("교통 관련 미션 3개 완료").enDesc("Complete 3 transport missions")
                .iconKey("transit").requiredMissionCount(3).build(),
            Badge.builder().koName("푸드 러버").enName("Food Lover")
                .koDesc("음식 관련 미션 2개 완료").enDesc("Complete 2 food missions")
                .iconKey("food").requiredMissionCount(2).build(),
            Badge.builder().koName("행정 챔피언").enName("Admin Champion")
                .koDesc("행정 관련 미션 2개 완료").enDesc("Complete 2 admin missions")
                .iconKey("admin").requiredMissionCount(2).build(),
            Badge.builder().koName("생활 전문가").enName("Daily Life Pro")
                .koDesc("생활 관련 미션 2개 완료").enDesc("Complete 2 daily missions")
                .iconKey("daily").requiredMissionCount(2).build(),
            Badge.builder().koName("안전 지킴이").enName("Safety Guardian")
                .koDesc("안전 관련 미션 2개 완료").enDesc("Complete 2 safety missions")
                .iconKey("safety").requiredMissionCount(2).build()
        );
        badgeRepository.saveAll(badges);
        log.info("[DataInitializer] {} badges seeded.", badges.size());
    }
}
