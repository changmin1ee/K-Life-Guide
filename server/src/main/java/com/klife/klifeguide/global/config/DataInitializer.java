package com.klife.klifeguide.global.config;

import com.klife.klifeguide.domain.community.repository.PostRepository;
import com.klife.klifeguide.domain.community.repository.ReplyRepository;
import com.klife.klifeguide.domain.mission.entity.Mission;
import com.klife.klifeguide.domain.mission.entity.MissionStep;
import com.klife.klifeguide.domain.mission.enums.MissionType;
import com.klife.klifeguide.domain.mission.repository.MissionRepository;
import com.klife.klifeguide.domain.mission.repository.MissionStepRepository;
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
    private final MissionStepRepository missionStepRepository;
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
        seedMissionSteps();
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

    private void seedMissionSteps() {
        if (missionStepRepository.count() > 0) return;
        log.info("[DataInitializer] Seeding mission steps...");

        List<Mission> missions = missionRepository.findAllByOrderBySortOrderAsc();
        if (missions.size() < 10) {
            log.warn("[DataInitializer] Missions not found, skipping steps seed.");
            return;
        }

        // sortOrder 기준으로 미션 인덱싱 (0-based: 0=지하철, 1=교통카드, ...)
        Mission subway     = missions.get(0);
        Mission tmoney     = missions.get(1);
        Mission delivery   = missions.get(2);
        Mission cvs        = missions.get(3);
        Mission arc        = missions.get(4);  // 외국인등록증
        Mission community  = missions.get(5);  // 주민센터
        Mission recycle    = missions.get(6);
        Mission bank       = missions.get(7);
        Mission emergency  = missions.get(8);
        Mission insurance  = missions.get(9);

        List<MissionStep> steps = List.of(
            // 1. 지하철 노선 확인하기
            step(subway, 1, "App Store / Play Store에서 '네이버지도' 또는 '카카오맵' 설치", "Install 'Naver Map' or 'Kakao Map' from the App Store / Play Store"),
            step(subway, 2, "앱 실행 → 검색창에 출발지·목적지 입력", "Open the app → Enter your departure and destination"),
            step(subway, 3, "상단 '대중교통' 탭 선택 → 노선·환승 횟수·소요 시간 비교", "Tap 'Public Transit' → Compare routes, transfers, and travel time"),
            step(subway, 4, "원하는 경로 선택 후 즐겨찾기 또는 스크린샷으로 저장", "Select a route and save it to favorites or take a screenshot"),
            step(subway, 5, "실제 탑승 시 앱 하단 '실시간' 버튼으로 다음 열차 시간 확인", "On the day, tap 'Live' to check the next train arrival"),

            // 2. 교통카드 충전하기
            step(tmoney, 1, "GS25·CU·세븐일레븐 등 편의점 방문", "Visit a convenience store: GS25, CU, or 7-Eleven"),
            step(tmoney, 2, "계산대 직원에게 '티머니 충전해 주세요, ○만원'이라고 요청", "Tell the cashier: '티머니 충전해 주세요' (Please charge my T-money)"),
            step(tmoney, 3, "직원 안내에 따라 카드를 단말기에 올리고 금액 확인 (최소 1,000원 단위)", "Place your card on the terminal and confirm the amount (min. 1,000 KRW)"),
            step(tmoney, 4, "현금 또는 카드로 결제. 티머니 앱(NFC)으로도 직접 충전 가능", "Pay in cash or by card. You can also charge via the T-money app using NFC"),
            step(tmoney, 5, "지하철·버스 탑승 시 단말기에 태그, 하차 시 반드시 다시 태그 (미태그 시 벌금)", "Tag your card on boarding AND on exit — missing the exit tag incurs a fine"),
            step(tmoney, 6, "잔액은 편의점 단말기 또는 티머니 앱에서 언제든 확인 가능", "Check your balance anytime at a convenience store terminal or T-money app"),

            // 3. 배달 앱으로 주문하기
            step(delivery, 1, "배달의민족 또는 쿠팡이츠 앱 설치 (한국 전화번호 인증 필요)", "Install Baemin or Coupang Eats (Korean phone number required for signup)"),
            step(delivery, 2, "앱 실행 → 주소 설정: 현재 위치 또는 직접 주소 입력", "Open the app → Set your address using GPS or type it manually"),
            step(delivery, 3, "음식 카테고리 선택 → 가게 선택 (별점·배달시간·최소주문금액 참고)", "Choose a category → Pick a restaurant (check ratings, delivery time, minimum order)"),
            step(delivery, 4, "메뉴 선택 → 장바구니 담기 → 결제 수단 등록 (카드·카카오페이 등)", "Select items → Add to cart → Register a payment method"),
            step(delivery, 5, "요청사항에 '문 앞에 놔주세요' 입력 후 '주문하기' 버튼 탭", "Enter '문 앞에 놔주세요' (leave at door) in notes, then tap 'Order'"),
            step(delivery, 6, "주문 완료 화면에서 예상 도착 시간 확인 후 스크린샷으로 인증", "Check estimated arrival time on the confirmation screen and take a screenshot to verify"),

            // 4. 편의점에서 상품 구매하기
            step(cvs, 1, "GS25·CU·세븐일레븐·이마트24 등 편의점 입장", "Enter a convenience store: GS25, CU, 7-Eleven, or emart24"),
            step(cvs, 2, "원하는 상품 선택 (냉장 음료, 삼각김밥, 컵라면 등 다양)", "Pick what you want — chilled drinks, triangle rice balls, cup noodles, and more"),
            step(cvs, 3, "컵라면은 매장 내 온수기 무료 이용 가능", "For cup noodles, use the free hot-water dispenser inside the store"),
            step(cvs, 4, "계산대에 상품 올리기 → 멤버십 앱 있으면 바코드 먼저 제시", "Place items on the counter → Show your membership app barcode first if you have one"),
            step(cvs, 5, "현금·신용카드·네이버페이·카카오페이·교통카드 모두 결제 가능", "Pay with cash, card, Naver Pay, Kakao Pay, or your T-money transport card"),

            // 5. 외국인 등록증 신청하기
            step(arc, 1, "입국 후 90일 이내 신청 필수 — 초과 시 과태료 부과", "Must apply within 90 days of entry — late applications incur a fine"),
            step(arc, 2, "하이코리아(hikorea.go.kr) 접속 → 가까운 출입국·외국인청 온라인 예약", "Go to hikorea.go.kr and book an appointment at the nearest immigration office"),
            step(arc, 3, "준비물: 여권 원본, 여권사진 1매(3.5×4.5cm), 수수료 30,000원", "Bring: original passport, 1 passport photo (3.5×4.5cm), and 30,000 KRW fee"),
            step(arc, 4, "예약 날짜에 출입국사무소 방문 → 번호표 뽑고 대기 → 창구에서 서류 제출", "Visit on your appointment date, take a number, wait, and submit your documents at the counter"),
            step(arc, 5, "신청 후 약 2~3주 후 등록증 수령 (현장 수령 또는 우편 수령 선택 가능)", "The card arrives in about 2–3 weeks — choose on-site pickup or postal delivery"),
            step(arc, 6, "등록증 수령 후 앞뒷면 사진 찍어 인증", "Once received, photograph both sides of your card for verification"),

            // 6. 주민센터 위치 파악하기
            step(community, 1, "네이버지도 앱 실행 → 검색창에 '주민센터' 또는 '○○동 주민센터' 입력", "Open Naver Map → Search for '주민센터' or '[your neighborhood] 주민센터'"),
            step(community, 2, "현재 위치 기준 가장 가까운 주민센터 선택 → 운영시간 확인", "Select the nearest one → Check opening hours (weekdays 09:00–18:00)"),
            step(community, 3, "일부 주민센터는 화요일 야간(19:00~21:00) 연장 운영 — 방문 전 확인 권장", "Some offices extend hours on Tuesdays (19:00–21:00) — check before visiting"),
            step(community, 4, "주민센터에서 할 수 있는 것: 전입신고, 체류지 변경신고, 각종 서류 발급", "Services available: address registration, change of residence, document issuance"),
            step(community, 5, "위치 확인 후 앱에서 즐겨찾기로 저장", "Save the location to your favorites in the map app"),

            // 7. 분리수거 방법 익히기
            step(recycle, 1, "일반 쓰레기는 반드시 '종량제 봉투' 사용 — 편의점·마트에서 구매 (20L 약 700원)", "Regular trash must go in a '종량제 봉투' (pay-per-bag) — sold at convenience stores (~700 KRW for 20L)"),
            step(recycle, 2, "종량제 봉투 없이 배출 시 과태료 부과 가능", "Disposing trash without the correct bag can result in a fine"),
            step(recycle, 3, "플라스틱: 라벨 제거 후 헹궈서 배출 / 캔: 찌그러뜨려서 배출", "Plastic: remove labels, rinse, then discard / Cans: crush and discard"),
            step(recycle, 4, "종이: 테이프·스테이플러 제거 후 묶어서 배출 / 유리병: 뚜껑 분리 후 배출", "Paper: remove tape/staples and bundle / Glass: remove lids before discarding"),
            step(recycle, 5, "음식물 쓰레기는 음식물 전용 봉투 사용 (아파트는 수거 카드 사용)", "Food waste goes in a food-waste bag (apartment residents use a collection card)"),
            step(recycle, 6, "배출 시간·수거 요일은 지역마다 다름 — 아파트 관리자 또는 건물 안내판 확인", "Disposal times and collection days vary — check with your building manager or posted notices"),

            // 8. 은행 계좌 개설하기
            step(bank, 1, "카카오뱅크 앱 설치 — 외국인 비대면 개설이 가장 간편", "Install KakaoBank — the easiest option for foreigners with no branch visit needed"),
            step(bank, 2, "앱 실행 → '계좌 만들기' → '외국인' 선택", "Open the app → Tap 'Open Account' → Select 'Foreigner'"),
            step(bank, 3, "외국인등록증(ARC) 앞뒷면 촬영 → 셀카 인증 → 한국 휴대폰 번호 인증", "Photograph both sides of your ARC → Take a selfie → Verify your Korean phone number"),
            step(bank, 4, "계좌 개설 완료까지 약 5~10분 소요", "The process takes about 5–10 minutes"),
            step(bank, 5, "시중은행(신한·국민·하나 등) 직접 방문 시: 여권·외국인등록증 지참", "For in-branch signup at Shinhan, KB, or Hana Bank: bring your passport and ARC"),
            step(bank, 6, "계좌 개설 완료 화면 스크린샷 찍어 인증", "Take a screenshot of the account confirmation screen for verification"),

            // 9. 긴급 연락처 저장하기
            step(emergency, 1, "연락처 앱 실행 → 새 연락처 추가", "Open your Contacts app → Add a new contact"),
            step(emergency, 2, "119 저장 — 소방서·구급차 (화재·응급환자, 24시간)", "Save 119 — Fire & Ambulance (fire, medical emergencies, 24/7)"),
            step(emergency, 3, "112 저장 — 경찰 신고 (범죄·사고·분실, 24시간)", "Save 112 — Police (crime, accidents, lost items, 24/7)"),
            step(emergency, 4, "1345 저장 — 외국인 종합안내 (영어·중국어 등 다국어 지원, 24시간)", "Save 1345 — Foreigner Helpline (English, Chinese, and more, 24/7)"),
            step(emergency, 5, "1339 저장 — 질병관리청 건강 상담 (영어 지원)", "Save 1339 — Health Helpline, Korea Disease Control (English available)"),
            step(emergency, 6, "한국어 못해도 1345에 전화하면 통역 연결해줌 — 꼭 저장", "Even without Korean, call 1345 and they'll connect you to an interpreter — save it now"),

            // 10. 의료보험 가입 확인하기
            step(insurance, 1, "App Store / Play Store에서 'The건강보험' 앱 설치", "Install the 'The건강보험' app from App Store or Play Store"),
            step(insurance, 2, "앱 실행 → 외국인 로그인: 외국인등록번호 + 간편 인증 진행", "Open the app → Log in as a foreigner using your ARC number + simple verification"),
            step(insurance, 3, "메인 화면 → '자격조회' → 건강보험 가입 여부 확인", "Go to 'Eligibility Check' on the main screen to see if you're enrolled"),
            step(insurance, 4, "직장가입자는 회사에서 자동 등록 / 지역가입자는 공단에 직접 신청 필요", "Employee subscribers are enrolled automatically / Self-employed must apply directly at NHIS"),
            step(insurance, 5, "미가입 시 가까운 국민건강보험공단 지사 방문 또는 1577-1000 전화", "If not enrolled, visit your nearest NHIS branch or call 1577-1000"),
            step(insurance, 6, "병원 방문 시 외국인등록증 제시 → 보험 적용으로 본인 부담 20~30%", "At hospitals, show your ARC → insurance covers most costs, you pay only 20–30%"),
            step(insurance, 7, "자격득실확인서 화면 스크린샷 찍어 인증", "Take a screenshot of your insurance eligibility screen for verification")
        );

        missionStepRepository.saveAll(steps);
        log.info("[DataInitializer] {} mission steps seeded.", steps.size());
    }

    private MissionStep step(Mission mission, int order, String ko, String en) {
        return MissionStep.builder()
                .mission(mission)
                .stepOrder(order)
                .koStep(ko)
                .enStep(en)
                .build();
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
