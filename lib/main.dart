import 'package:flutter/material.dart';

void main() => runApp(const KLifeGuideApp());

class C {
  static const bg = Color(0xFFF7F8FA);
  static const black = Color(0xFF191F28);
  static const gray = Color(0xFF6B7684);
  static const light = Color(0xFFE5E8EB);
  static const blue = Color(0xFF3182F6);
  static const blueSoft = Color(0xFFE8F3FF);
  static const green = Color(0xFF00A86B);
  static const greenSoft = Color(0xFFE7F8F0);
  static const orange = Color(0xFFFF8A00);
  static const orangeSoft = Color(0xFFFFF3E0);
}

enum AppLang { ko, en }
enum MissionType { verify, guide }
enum MissionFilter { all, verify, guide }
enum BoardFilter { free, qna }

class Mission {
  const Mission({
    required this.icon,
    required this.type,
    required this.koCategory,
    required this.enCategory,
    required this.koTitle,
    required this.enTitle,
    required this.koDesc,
    required this.enDesc,
    required this.xp,
    required this.point,
    required this.progress,
    required this.koStatus,
    required this.enStatus,
    required this.koSteps,
    required this.enSteps,
  });

  final IconData icon;
  final MissionType type;
  final String koCategory;
  final String enCategory;
  final String koTitle;
  final String enTitle;
  final String koDesc;
  final String enDesc;
  final int xp;
  final int point;
  final double progress;
  final String koStatus;
  final String enStatus;
  final List<String> koSteps;
  final List<String> enSteps;

  String category(AppLang lang) => lang == AppLang.ko ? koCategory : enCategory;
  String title(AppLang lang) => lang == AppLang.ko ? koTitle : enTitle;
  String desc(AppLang lang) => lang == AppLang.ko ? koDesc : enDesc;
  String status(AppLang lang) => lang == AppLang.ko ? koStatus : enStatus;
  List<String> steps(AppLang lang) => lang == AppLang.ko ? koSteps : enSteps;
}

const missions = [
  Mission(
    icon: Icons.credit_card_rounded,
    type: MissionType.verify,
    koCategory: '교통',
    enCategory: 'Transport',
    koTitle: 'T머니 카드 충전하기',
    enTitle: 'Top up a T-money card',
    koDesc: '편의점 또는 지하철역에서 교통카드를 충전하고 사진으로 인증해요.',
    enDesc: 'Top up your transit card and submit a photo.',
    xp: 30,
    point: 300,
    progress: .65,
    koStatus: '인증 필요',
    enStatus: 'Needs proof',
    koSteps: [
      '편의점 또는 지하철역 충전기를 찾아요.',
      'T머니 카드를 제시하고 충전 금액을 말해요.',
      '충전 완료 화면이나 영수증을 앱 내 카메라로 촬영해요.',
    ],
    enSteps: [
      'Find a store or subway top-up machine.',
      'Present your T-money card and say the amount.',
      'Take a photo of the receipt or completed top-up screen.',
    ],
  ),
  Mission(
    icon: Icons.restaurant_rounded,
    type: MissionType.verify,
    koCategory: '음식',
    enCategory: 'Food',
    koTitle: '키오스크로 주문하기',
    enTitle: 'Order with a kiosk',
    koDesc: '매장에서 키오스크 주문을 완료하고 완료 화면을 촬영해요.',
    enDesc: 'Complete an order at a kiosk and capture the order screen.',
    xp: 40,
    point: 400,
    progress: 0,
    koStatus: '수락 가능',
    enStatus: 'Available',
    koSteps: [
      '키오스크에서 언어를 선택해요.',
      '메뉴를 고르고 결제를 진행해요.',
      '주문 번호 화면을 앱 내 카메라로 촬영해요.',
    ],
    enSteps: [
      'Choose a language on the kiosk.',
      'Select a menu item and pay.',
      'Take a photo of the order number screen.',
    ],
  ),
  Mission(
    icon: Icons.badge_rounded,
    type: MissionType.guide,
    koCategory: '행정',
    enCategory: 'Admin',
    koTitle: '외국인등록증 발급 가이드',
    enTitle: 'Alien registration card guide',
    koDesc: '필요 서류, 방문 예약, 신청 순서를 사진과 텍스트로 확인해요.',
    enDesc: 'Check documents, reservation steps, and the application flow.',
    xp: 10,
    point: 100,
    progress: .25,
    koStatus: '읽는 중',
    enStatus: 'Reading',
    koSteps: [
      'HiKorea에서 방문 예약을 진행해요.',
      '여권, 증명사진, 신청서, 수수료를 준비해요.',
      '예약한 날짜에 출입국·외국인청에 방문해 신청서를 제출해요.',
    ],
    enSteps: [
      'Make a visit reservation on HiKorea.',
      'Prepare your passport, photo, application form, and fee.',
      'Visit the immigration office and submit the form.',
    ],
  ),
  Mission(
    icon: Icons.account_balance_rounded,
    type: MissionType.guide,
    koCategory: '행정',
    enCategory: 'Admin',
    koTitle: '통장 개설 준비 가이드',
    enTitle: 'Bank account setup guide',
    koDesc: '은행 방문 전 필요한 서류와 계좌 개설 흐름을 확인해요.',
    enDesc: 'Review documents and account-opening steps before visiting a bank.',
    xp: 10,
    point: 100,
    progress: 0,
    koStatus: '읽기 전',
    enStatus: 'Not started',
    koSteps: [
      '여권과 외국인등록증을 준비해요.',
      '학교 또는 직장 관련 증빙 서류가 필요한지 확인해요.',
      '은행 창구에서 입출금 계좌 개설을 요청해요.',
    ],
    enSteps: [
      'Prepare your passport and alien registration card.',
      'Check if school or workplace proof is required.',
      'Ask the bank teller to open an account.',
    ],
  ),
  Mission(
    icon: Icons.local_taxi_rounded,
    type: MissionType.verify,
    koCategory: '교통',
    enCategory: 'Transport',
    koTitle: '카카오T로 택시 호출하기',
    enTitle: 'Call a taxi with Kakao T',
    koDesc: '목적지를 입력하고 예상 요금을 확인한 뒤 호출 과정을 익혀요.',
    enDesc: 'Enter a destination, check the estimated fare, and practice the taxi call flow.',
    xp: 35,
    point: 350,
    progress: 0,
    koStatus: '수락 가능',
    enStatus: 'Available',
    koSteps: [
      '현재 위치와 목적지를 정확히 입력해요.',
      '예상 요금과 이동 시간을 확인해요.',
      '호출 완료 화면을 캡처하거나 앱 내 인증으로 확인해요.',
    ],
    enSteps: [
      'Enter your current location and destination.',
      'Check the estimated fare and travel time.',
      'Capture the completed call screen or verify it in the app.',
    ],
  ),
  Mission(
    icon: Icons.delivery_dining_rounded,
    type: MissionType.guide,
    koCategory: '음식',
    enCategory: 'Food',
    koTitle: '배달앱 주문 준비 가이드',
    enTitle: 'Delivery app order guide',
    koDesc: '주소 입력, 요청사항 작성, 결제 방식까지 배달 주문 전 과정을 확인해요.',
    enDesc: 'Learn address entry, request notes, payment methods, and delivery order basics.',
    xp: 15,
    point: 150,
    progress: 0,
    koStatus: '읽기 전',
    enStatus: 'Not started',
    koSteps: [
      '도로명 주소와 상세 주소를 정확히 입력해요.',
      '문 앞에 두기, 연락 요청 등 배달 요청사항을 작성해요.',
      '결제 방식과 예상 도착 시간을 확인해요.',
    ],
    enSteps: [
      'Enter the road-name address and detailed address correctly.',
      'Write delivery notes such as leave at the door or call me.',
      'Check payment method and estimated arrival time.',
    ],
  ),
  Mission(
    icon: Icons.local_hospital_rounded,
    type: MissionType.guide,
    koCategory: '생활',
    enCategory: 'Daily life',
    koTitle: '병원·약국 이용 가이드',
    enTitle: 'Clinic and pharmacy guide',
    koDesc: '증상 설명, 접수, 처방전, 약국 방문 흐름을 쉽게 익혀요.',
    enDesc: 'Learn how to explain symptoms, register at a clinic, get a prescription, and visit a pharmacy.',
    xp: 20,
    point: 200,
    progress: 0,
    koStatus: '읽기 전',
    enStatus: 'Not started',
    koSteps: [
      '가까운 병원 또는 약국 영업시간을 확인해요.',
      '증상을 간단한 문장으로 준비해요.',
      '처방전을 받은 뒤 약국에서 약을 수령해요.',
    ],
    enSteps: [
      'Check nearby clinic or pharmacy hours.',
      'Prepare simple sentences to explain your symptoms.',
      'Receive the prescription and pick up medicine at a pharmacy.',
    ],
  ),
  Mission(
    icon: Icons.delete_outline_rounded,
    type: MissionType.verify,
    koCategory: '생활',
    enCategory: 'Daily life',
    koTitle: '분리수거 배출하기',
    enTitle: 'Sort and take out recycling',
    koDesc: '플라스틱, 종이, 일반 쓰레기 구분을 확인하고 올바르게 배출해요.',
    enDesc: 'Check recycling categories and take out waste correctly.',
    xp: 25,
    point: 250,
    progress: 0,
    koStatus: '수락 가능',
    enStatus: 'Available',
    koSteps: [
      '플라스틱, 종이, 캔, 일반 쓰레기를 구분해요.',
      '지역별 배출 요일과 시간을 확인해요.',
      '배출 장소에 정리한 뒤 인증 사진을 촬영해요.',
    ],
    enSteps: [
      'Separate plastic, paper, cans, and general waste.',
      'Check local disposal days and times.',
      'Place items at the disposal area and take a proof photo.',
    ],
  ),
  Mission(
    icon: Icons.sim_card_rounded,
    type: MissionType.guide,
    koCategory: '생활',
    enCategory: 'Daily life',
    koTitle: '유심·eSIM 개통 가이드',
    enTitle: 'SIM and eSIM setup guide',
    koDesc: '한국 번호 개통 전 준비물, 본인인증, 요금제 선택 흐름을 확인해요.',
    enDesc: 'Review what to prepare before getting a Korean number, identity verification, and plan selection.',
    xp: 18,
    point: 180,
    progress: 0,
    koStatus: '읽기 전',
    enStatus: 'Not started',
    koSteps: [
      '여권 또는 외국인등록증 등 본인확인 서류를 준비해요.',
      '선불, 후불, eSIM 중 본인에게 맞는 방식을 비교해요.',
      '개통 후 본인인증 문자 수신이 가능한지 확인해요.',
    ],
    enSteps: [
      'Prepare identity documents such as a passport or alien registration card.',
      'Compare prepaid, postpaid, and eSIM options.',
      'After activation, check whether identity verification messages work.',
    ],
  ),
  Mission(
    icon: Icons.contact_phone_rounded,
    type: MissionType.verify,
    koCategory: '안전',
    enCategory: 'Safety',
    koTitle: '긴급 연락처 저장하기',
    enTitle: 'Save emergency contacts',
    koDesc: '119, 112, 학교·회사 담당자, 가까운 지인의 연락처를 저장하고 확인해요.',
    enDesc: 'Save and check emergency contacts such as 119, 112, your school or workplace contact, and a trusted person.',
    xp: 30,
    point: 300,
    progress: 0,
    koStatus: '수락 가능',
    enStatus: 'Available',
    koSteps: [
      '119, 112 등 기본 긴급 번호를 저장해요.',
      '학교, 회사, 기숙사 또는 집주인 연락처를 저장해요.',
      '연락처 목록 화면을 앱 내 인증으로 확인해요.',
    ],
    enSteps: [
      'Save basic emergency numbers such as 119 and 112.',
      'Save your school, workplace, dormitory, or landlord contact.',
      'Verify the contact list screen in the app.',
    ],
  ),
];

class KLifeGuideApp extends StatefulWidget {
  const KLifeGuideApp({super.key});

  @override
  State<KLifeGuideApp> createState() => _KLifeGuideAppState();
}

class _KLifeGuideAppState extends State<KLifeGuideApp> {
  AppLang lang = AppLang.ko;
  bool loggedIn = false;

  void changeLang(AppLang value) {
    setState(() => lang = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Life Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: C.blue),
        navigationBarTheme: NavigationBarThemeData(
          height: 74,
          backgroundColor: Colors.white,
          indicatorColor: C.blueSoft,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
              color: selected ? C.blue : C.gray,
            );
          }),
        ),
      ),
      home: loggedIn
          ? Tabs(lang: lang, onLangChanged: changeLang)
          : LoginPage(
              lang: lang,
              onLangChanged: changeLang,
              onLogin: () => setState(() => loggedIn = true),
            ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.lang,
    required this.onLangChanged,
    required this.onLogin,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;
  final VoidCallback onLogin;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: LangButton(
                  lang: lang,
                  onTap: () => showLanguageSheet(context, lang, onLangChanged),
                ),
              ),
              const Spacer(),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 22,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                en ? 'Settle in Korea\nwith simple missions' : '한국 생활을\n미션처럼 쉽게',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 36,
                  height: 1.15,
                  letterSpacing: -1.4,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                en
                    ? 'Transport, food, and admin guides\nfor foreigners living in Korea.'
                    : '교통, 음식, 행정 가이드까지\n외국인을 위한 정착 정보를 한 곳에서 확인하세요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 34),
              FeatureCard(
                icon: Icons.flag_rounded,
                title: en ? 'Mission-based guide' : '미션 기반 정착 가이드',
                subtitle: en ? 'Follow practical steps one by one' : '해야 할 일을 단계별로 확인하고 완료해요',
              ),
              const SizedBox(height: 10),
              FeatureCard(
                icon: Icons.card_giftcard_rounded,
                title: en ? 'XP and point rewards' : 'XP와 포인트 보상',
                subtitle: en ? 'Grow your level as you complete missions' : '완료할 때마다 성장 기록이 쌓여요',
              ),
              const Spacer(),
              PrimaryButton(
                label: en ? 'Continue with Google' : 'Google 계정으로 계속하기',
                icon: Icons.g_mobiledata_rounded,
                onTap: onLogin,
              ),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  en
                      ? 'By continuing, you agree to the Terms and Privacy Policy.'
                      : '로그인하면 서비스 이용약관과 개인정보처리방침에 동의하게 됩니다.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: C.gray,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  const Tabs({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final en = widget.lang == AppLang.en;

    final pages = [
      HomeScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
      MissionScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
      CommunityScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
      ProfileScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: en ? 'Home' : '홈',
          ),
          NavigationDestination(
            icon: const Icon(Icons.flag_outlined),
            selectedIcon: const Icon(Icons.flag_rounded),
            label: en ? 'Missions' : '미션',
          ),
          NavigationDestination(
            icon: const Icon(Icons.forum_outlined),
            selectedIcon: const Icon(Icons.forum_rounded),
            label: en ? 'Community' : '커뮤니티',
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person_rounded),
            label: en ? 'Profile' : '프로필',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final active = missions.where((m) => m.progress > 0).toList();

    return PageShell(
      lang: lang,
      onLangChanged: onLangChanged,
      title: en ? 'Home' : '홈',
      subtitle: en ? 'One more step toward life in Korea.' : '오늘도 한국 생활에 한 걸음 더 가까워져요.',
      children: [
        ProfileCard(lang: lang),
        const SizedBox(height: 14),
        TodayBriefCard(
          lang: lang,
          onPrimaryTap: () => openMission(context, missions.first, lang, onLangChanged),
          onSecondaryTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TodayChecklistScreen(lang: lang),
            ),
          ),
        ),
        const SizedBox(height: 14),
        KLifePassportCard(
          lang: lang,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PassportScreen(lang: lang)),
          ),
        ),
        const SizedBox(height: 14),
        SurvivalPhraseCard(
          lang: lang,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SurvivalPhraseScreen(lang: lang)),
          ),
        ),
        const SizedBox(height: 14),
        SettlementRoadmapCard(
          lang: lang,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SettlementRoadmapScreen(lang: lang)),
          ),
        ),
        Header(
          title: en ? 'In progress' : '진행 중인 미션',
          action: '${active.length}',
        ),
        ...active.map(
          (m) => MissionCard(
            mission: m,
            lang: lang,
            onTap: () => openMission(context, m, lang, onLangChanged),
          ),
        ),
        Header(
          title: en ? 'Completed' : '완료한 미션',
          action: '3',
        ),
        DoneTile(
          title: en ? 'Check subway routes' : '지하철 노선 확인하기',
          lang: lang,
        ),
        DoneTile(
          title: en ? 'Learn recycling rules' : '분리수거 방법 익히기',
          lang: lang,
        ),
        DoneTile(
          title: en ? 'Buy something at a convenience store' : '편의점에서 상품 구매하기',
          lang: lang,
        ),
      ],
    );
  }
}

class MissionScreen extends StatefulWidget {
  const MissionScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  MissionFilter filter = MissionFilter.all;

  @override
  Widget build(BuildContext context) {
    final en = widget.lang == AppLang.en;

    final filtered = missions.where((m) {
      if (filter == MissionFilter.all) return true;
      if (filter == MissionFilter.verify) return m.type == MissionType.verify;
      return m.type == MissionType.guide;
    }).toList();

    return PageShell(
      lang: widget.lang,
      onLangChanged: widget.onLangChanged,
      title: en ? 'Missions' : '미션',
      subtitle: en ? 'Verification missions and admin guides.' : '검증 미션과 행정 가이드를 한 곳에서 관리해요.',
      children: [
        MissionInsightCard(lang: widget.lang),
        const SizedBox(height: 14),
        FilterBar(
          labels: en ? const ['All', 'Verify', 'Guides'] : const ['전체', '검증', '가이드'],
          selected: filter.index,
          onTap: (i) => setState(() => filter = MissionFilter.values[i]),
        ),
        Header(
          title: en ? 'Recommended' : '추천 미션',
          action: '${filtered.length}',
        ),
        ...filtered.map(
          (m) => MissionCard(
            mission: m,
            lang: widget.lang,
            onTap: () => openMission(
              context,
              m,
              widget.lang,
              widget.onLangChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  BoardFilter filter = BoardFilter.qna;

  @override
  Widget build(BuildContext context) {
    final en = widget.lang == AppLang.en;

    final qna = [
      [
        en ? 'Where can I top up T-money?' : 'T머니 충전은 어디서 할 수 있나요?',
        en ? '3 replies · 5 likes' : '댓글 3 · 추천 5',
      ],
      [
        en ? 'How do I reserve an ARC visit?' : '외국인등록증 예약은 어떻게 하나요?',
        en ? '8 replies · 12 likes' : '댓글 8 · 추천 12',
      ],
    ];

    final free = [
      [
        en ? 'My first time using the Korean subway' : '처음 한국 지하철을 타본 후기',
        en ? '2 replies · 7 likes' : '댓글 2 · 추천 7',
      ],
      [
        en ? 'Useful words at convenience stores' : '편의점에서 자주 쓰는 말 정리',
        en ? '1 reply · 4 likes' : '댓글 1 · 추천 4',
      ],
    ];

    final posts = filter == BoardFilter.qna ? qna : free;

    return PageShell(
      lang: widget.lang,
      onLangChanged: widget.onLangChanged,
      title: en ? 'Community' : '커뮤니티',
      subtitle: en ? 'Ask questions and share local tips.' : '질문하고 생활 정보를 공유해요.',
      children: [
        CommunityPulseCard(lang: widget.lang),
        const SizedBox(height: 14),
        FilterBar(
          labels: en ? const ['Free board', 'Q&A'] : const ['자유게시판', 'Q&A'],
          selected: filter.index,
          onTap: (i) => setState(() => filter = BoardFilter.values[i]),
        ),
        Header(
          title: filter == BoardFilter.qna
              ? (en ? 'Popular Q&A' : '인기 질문')
              : (en ? 'Free board' : '자유게시판'),
        ),
        ...posts.map(
          (p) => PostTile(
            board: filter == BoardFilter.qna ? 'Q&A' : 'FREE',
            title: p[0],
            meta: p[1],
            onTap: () => openPost(context, p[0], widget.lang),
          ),
        ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: en ? 'Write post' : '글쓰기',
          icon: Icons.edit_rounded,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => WritePostScreen(lang: widget.lang),
            ),
          ),
        ),
      ],
    );
  }
}


class MissionInsightCard extends StatelessWidget {
  const MissionInsightCard({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_graph_rounded, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      en ? 'Smart mission route' : '스마트 미션 루트',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                en ? '10 available' : '10개 가능',
                style: TextStyle(
                  color: Colors.white.withOpacity(.72),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            en ? 'Start with what helps your real life today.' : '오늘 실제 생활에 바로 도움이 되는 것부터 시작해요',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              height: 1.22,
              letterSpacing: -0.7,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            en
                ? 'Verification missions build confidence, while practical guides reduce mistakes before real visits and orders.'
                : '인증 미션은 실생활 자신감을 높이고, 실전 가이드는 방문·주문 전 실수를 줄여줍니다.',
            style: TextStyle(
              color: Colors.white.withOpacity(.68),
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: MissionInsightStat(label: en ? 'Verify' : '검증', value: '5')),
              const SizedBox(width: 8),
              Expanded(child: MissionInsightStat(label: en ? 'Guides' : '가이드', value: '5')),
              const SizedBox(width: 8),
              Expanded(child: MissionInsightStat(label: en ? 'Rewards' : '보상', value: '2,330P')),
            ],
          ),
        ],
      ),
    );
  }
}

class MissionInsightStat extends StatelessWidget {
  const MissionInsightStat({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(.62),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityPulseCard extends StatelessWidget {
  const CommunityPulseCard({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified_user_rounded, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      en ? 'Trusted local answers' : '검증된 생활 답변',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                en ? '12 solved' : '12건 해결',
                style: TextStyle(
                  color: Colors.white.withOpacity(.72),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            en ? 'Ask fast. Get practical Korean life tips.' : '빠르게 묻고, 실제 한국 생활 답변을 받아요',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              height: 1.22,
              letterSpacing: -0.7,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            en
                ? 'Solved answers are highlighted so newcomers can trust what to do next.'
                : '해결된 답변을 우선 보여줘서 새 정착자가 다음 행동을 쉽게 결정할 수 있습니다.',
            style: TextStyle(
              color: Colors.white.withOpacity(.68),
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: CommunityPulseStat(label: en ? 'Avg reply' : '평균 답변', value: en ? '8 min' : '8분')),
              const SizedBox(width: 8),
              Expanded(child: CommunityPulseStat(label: en ? 'Solved' : '해결률', value: '84%')),
              const SizedBox(width: 8),
              Expanded(child: CommunityPulseStat(label: en ? 'Helpers' : '도움 유저', value: '32')),
            ],
          ),
        ],
      ),
    );
  }
}

class CommunityPulseStat extends StatelessWidget {
  const CommunityPulseStat({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.10),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(.62),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return PageShell(
      lang: lang,
      onLangChanged: onLangChanged,
      title: en ? 'Profile' : '프로필',
      subtitle: en ? 'Track your settlement progress.' : '나의 정착 성장 기록을 확인해요.',
      children: [
        ProfileCard(
          lang: lang,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PointHistoryScreen(lang: lang)),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BadgeCollectionScreen(lang: lang),
                  ),
                ),
                borderRadius: BorderRadius.circular(28),
                child: SummaryBox(
                  icon: Icons.workspace_premium_rounded,
                  title: en ? 'Badges' : '뱃지',
                  value: '4',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyPostsScreen(lang: lang),
                  ),
                ),
                borderRadius: BorderRadius.circular(28),
                child: SummaryBox(
                  icon: Icons.forum_rounded,
                  title: en ? 'Posts' : '게시글',
                  value: '8',
                ),
              ),
            ),
          ],
        ),
        Header(title: en ? 'My activity' : '내 활동'),
        MenuTile(
          icon: Icons.flag_rounded,
          title: en ? 'Completed missions' : '완료한 미션',
          subtitle: en ? '12 completed' : '12개 완료',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CompletedMissionsScreen(lang: lang),
            ),
          ),
        ),
        MenuTile(
          icon: Icons.workspace_premium_rounded,
          title: en ? 'Badges' : '획득한 뱃지',
          subtitle: en ? '4 earned' : '4개 획득',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BadgeCollectionScreen(lang: lang),
            ),
          ),
        ),
        MenuTile(
          icon: Icons.language_rounded,
          title: en ? 'Language' : '언어 설정',
          subtitle: en ? 'English / Korean' : '한국어 / English',
          onTap: () => showLanguageSheet(context, lang, onLangChanged),
        ),
        MenuTile(
          icon: Icons.edit_note_rounded,
          title: en ? 'My posts' : '내가 쓴 글',
          subtitle: en ? 'Posts and comments' : '게시글과 댓글 보기',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MyPostsScreen(lang: lang),
            ),
          ),
        ),
      ],
    );
  }
}

class PageShell extends StatelessWidget {
  const PageShell({
    super.key,
    required this.lang,
    required this.onLangChanged,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;
  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: C.black,
                          fontSize: 31,
                          height: 1.1,
                          letterSpacing: -1.2,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: C.gray,
                          fontSize: 15,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                LangButton(
                  lang: lang,
                  onTap: () => showLanguageSheet(context, lang, onLangChanged),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}

class TossCard extends StatelessWidget {
  const TossCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class TodayBriefCard extends StatelessWidget {
  const TodayBriefCard({
    super.key,
    required this.lang,
    required this.onPrimaryTap,
    required this.onSecondaryTap,
  });

  final AppLang lang;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSecondaryTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: C.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      en ? 'Today recommendation' : '오늘의 추천',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '+30 XP',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.72),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            en ? 'Start with a transport mission today' : '오늘은 교통 미션부터 시작해보세요',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              height: 1.22,
              letterSpacing: -0.7,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            en
                ? 'It is practical, quick to verify, and helps you get used to daily movement in Korea.'
                : '실제로 자주 쓰는 기능이고, 인증도 간단해서 첫 정착 미션으로 적합합니다.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.68),
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onPrimaryTap,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        en ? 'Start' : '바로 시작',
                        style: const TextStyle(
                          color: C.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: onSecondaryTap,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        en ? 'Checklist' : '체크리스트',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class TodayChecklistScreen extends StatefulWidget {
  const TodayChecklistScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<TodayChecklistScreen> createState() => _TodayChecklistScreenState();
}

class _TodayChecklistScreenState extends State<TodayChecklistScreen> {
  late List<bool> checked;

  bool get en => widget.lang == AppLang.en;

  @override
  void initState() {
    super.initState();
    checked = [true, true, false, false];
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      [
        Icons.credit_card_rounded,
        en ? 'Carry your T-money card' : 'T머니 카드 챙기기',
        en ? 'Useful for subway, bus, and convenience stores.' : '지하철, 버스, 편의점에서 자주 사용합니다.',
      ],
      [
        Icons.location_on_rounded,
        en ? 'Save your home address' : '집 주소 저장하기',
        en ? 'You will need it for taxi, delivery, and admin forms.' : '택시, 배달, 행정 서류 작성에 필요합니다.',
      ],
      [
        Icons.translate_rounded,
        en ? 'Prepare one useful phrase' : '오늘 쓸 표현 하나 준비하기',
        en ? 'Example: Please charge 10,000 won.' : '예시: 만 원 충전해주세요.',
      ],
      [
        Icons.assignment_rounded,
        en ? 'Check one admin task' : '행정 할 일 하나 확인하기',
        en ? 'Review documents before visiting an office.' : '기관 방문 전 필요한 서류를 확인합니다.',
      ],
    ];

    final doneCount = checked.where((v) => v).length;
    final progress = doneCount / checked.length;
    final percent = (progress * 100).round();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'Today checklist' : '오늘의 체크리스트',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en
                    ? 'A practical daily routine for settling into life in Korea.'
                    : '한국 생활에 빨리 적응하기 위한 실전형 하루 루틴입니다.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: percent == 100 ? C.green : C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Daily readiness' : '오늘의 준비도',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$percent%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 11,
                        color: Colors.white,
                        backgroundColor: const Color(0x33FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      percent == 100
                          ? (en
                              ? 'Great. Today’s settlement routine is complete.'
                              : '좋아요. 오늘의 정착 루틴을 모두 완료했습니다.')
                          : (en
                              ? '${checked.length - doneCount} actions left to finish today’s routine.'
                              : '${checked.length - doneCount}가지를 더 완료하면 오늘의 루틴이 끝납니다.'),
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Header(
                title: en ? 'Practical actions' : '실전 행동 목록',
                action: '$doneCount/${checked.length}',
              ),
              ...List.generate(
                items.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () => setState(() => checked[i] = !checked[i]),
                    borderRadius: BorderRadius.circular(28),
                    child: TossCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconBox(
                            icon: items[i][0] as IconData,
                            color: checked[i] ? C.green : C.blue,
                            bg: checked[i] ? C.greenSoft : C.blueSoft,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[i][1] as String,
                                  style: const TextStyle(
                                    color: C.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  items[i][2] as String,
                                  style: const TextStyle(
                                    color: C.gray,
                                    fontSize: 13,
                                    height: 1.35,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            child: Icon(
                              checked[i]
                                  ? Icons.check_circle_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              key: ValueKey(checked[i]),
                              color: checked[i] ? C.green : C.gray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: percent == 100
                    ? (en ? 'Routine completed' : '오늘 루틴 완료')
                    : (en ? 'Start recommended mission' : '추천 미션 시작하기'),
                icon: percent == 100 ? Icons.check_rounded : Icons.flag_rounded,
                color: percent == 100 ? C.green : C.blue,
                onTap: () {
                  if (percent == 100) {
                    toast(context, en ? 'Great job today.' : '오늘도 잘 해냈습니다.');
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MissionDetailScreen(
                        mission: missions.first,
                        lang: widget.lang,
                        onLangChanged: (_) {},
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KLifePassportCard extends StatelessWidget {
  const KLifePassportCard({
    super.key,
    required this.lang,
    required this.onTap,
  });

  final AppLang lang;
  final VoidCallback onTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: C.blueSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.map_rounded, color: C.blue, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        en ? 'K-Life Passport' : 'K-라이프 패스포트',
                        style: const TextStyle(
                          color: C.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        en ? 'Your settlement readiness map' : '한국 생활 적응도를 한눈에 보는 지도',
                        style: const TextStyle(
                          color: C.gray,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: C.gray),
              ],
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: const LinearProgressIndicator(
                value: .58,
                minHeight: 10,
                color: C.blue,
                backgroundColor: C.blueSoft,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: PassportMiniStat(label: en ? 'Transport' : '교통', value: '70%')),
                const SizedBox(width: 8),
                Expanded(child: PassportMiniStat(label: en ? 'Food' : '음식', value: '45%')),
                const SizedBox(width: 8),
                Expanded(child: PassportMiniStat(label: en ? 'Admin' : '행정', value: '30%')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PassportMiniStat extends StatelessWidget {
  const PassportMiniStat({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: C.bg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: C.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: C.gray,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class SurvivalPhraseCard extends StatelessWidget {
  const SurvivalPhraseCard({
    super.key,
    required this.lang,
    required this.onTap,
  });

  final AppLang lang;
  final VoidCallback onTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: C.orangeSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.record_voice_over_rounded, color: C.orange, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    en ? 'Survival phrases' : '생활 필수 표현',
                    style: const TextStyle(
                      color: C.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    en ? 'Taxi, hospital, delivery, and emergency Korean' : '택시, 병원, 배달, 긴급 상황 한국어',
                    style: const TextStyle(
                      color: C.gray,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: C.gray),
          ],
        ),
      ),
    );
  }
}

class SurvivalPhraseScreen extends StatefulWidget {
  const SurvivalPhraseScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<SurvivalPhraseScreen> createState() => _SurvivalPhraseScreenState();
}

class _SurvivalPhraseScreenState extends State<SurvivalPhraseScreen> {
  int selected = 0;
  final Set<String> savedPhrases = {};

  bool get en => widget.lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final categories = en
        ? ['Transport', 'Food', 'Hospital', 'Emergency']
        : ['교통', '음식', '병원', '긴급'];

    final phrases = [
      [
        [en ? 'Please go to this address.' : '이 주소로 가주세요.', en ? 'Show this when taking a taxi.' : '택시를 탈 때 보여주면 좋아요.'],
        [en ? 'Please stop here.' : '여기서 세워주세요.', en ? 'Use this when you arrive nearby.' : '목적지 근처에 도착했을 때 사용해요.'],
        [en ? 'How much is the fare?' : '요금이 얼마인가요?', en ? 'Useful before paying.' : '결제 전에 확인할 때 사용해요.'],
      ],
      [
        [en ? 'Please leave it at the door.' : '문 앞에 놓아주세요.', en ? 'Useful for delivery requests.' : '배달 요청사항에 자주 사용돼요.'],
        [en ? 'Please remove spicy sauce.' : '매운 소스는 빼주세요.', en ? 'Good for kiosk or delivery orders.' : '키오스크나 배달 주문에서 유용해요.'],
        [en ? 'Can I pay by card?' : '카드 결제 되나요?', en ? 'Use this before ordering or buying.' : '주문이나 구매 전에 확인할 수 있어요.'],
      ],
      [
        [en ? 'I have a fever.' : '열이 있어요.', en ? 'Use this at a clinic or pharmacy.' : '병원이나 약국에서 사용할 수 있어요.'],
        [en ? 'My stomach hurts.' : '배가 아파요.', en ? 'Simple symptom explanation.' : '간단한 증상 설명 표현이에요.'],
        [en ? 'How should I take this medicine?' : '이 약은 어떻게 먹어야 하나요?', en ? 'Important when receiving medicine.' : '약을 받을 때 꼭 확인해야 해요.'],
      ],
      [
        [en ? 'Please help me.' : '도와주세요.', en ? 'Use this first in urgent situations.' : '긴급 상황에서 가장 먼저 사용할 표현이에요.'],
        [en ? 'Please call 119.' : '119에 전화해주세요.', en ? 'For fire, rescue, or medical emergencies.' : '화재, 구조, 응급 상황에서 사용해요.'],
        [en ? 'Please call the police.' : '경찰을 불러주세요.', en ? 'Use this when you need police help.' : '경찰 도움이 필요할 때 사용해요.'],
      ],
    ];

    final current = phrases[selected];
    final currentSavedCount = current
        .where((p) => savedPhrases.contains('${categories[selected]}-${p[0]}'))
        .length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'Survival phrases' : '생활 필수 표현',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en
                    ? 'Short Korean phrases you can show or say in real situations.'
                    : '실제 상황에서 보여주거나 말할 수 있는 짧은 한국어 표현입니다.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Quick use mode' : '빠른 사용 모드',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      en ? 'Tap a phrase to save it for quick reuse.' : '표현을 누르면 즐겨찾기로 저장됩니다.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        height: 1.22,
                        letterSpacing: -0.8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      en
                          ? 'Saved phrases stay highlighted, just like a future favorites feature.'
                          : '저장한 표현은 강조 표시되어 나중에 즐겨찾기 기능으로 확장할 수 있습니다.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              FilterBar(
                labels: categories,
                selected: selected,
                onTap: (i) => setState(() => selected = i),
              ),
              Header(
                title: en ? 'Useful phrases' : '유용한 표현',
                action: '$currentSavedCount/${current.length}',
              ),
              ...current.map(
                (p) {
                  final key = '${categories[selected]}-${p[0]}';
                  final saved = savedPhrases.contains(key);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (saved) {
                            savedPhrases.remove(key);
                          } else {
                            savedPhrases.add(key);
                          }
                        });
                        toast(
                          context,
                          saved
                              ? (en ? 'Phrase removed from favorites.' : '저장한 표현을 해제했습니다.')
                              : (en ? 'Phrase saved to favorites.' : '표현을 즐겨찾기에 저장했습니다.'),
                        );
                      },
                      borderRadius: BorderRadius.circular(28),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: saved ? C.orangeSoft : Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: saved ? C.orangeSoft : Colors.white),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 18,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            IconBox(
                              icon: saved ? Icons.bookmark_rounded : Icons.translate_rounded,
                              color: saved ? C.orange : C.orange,
                              bg: saved ? Colors.white : C.orangeSoft,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p[0],
                                    style: const TextStyle(
                                      color: C.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    p[1],
                                    style: const TextStyle(
                                      color: C.gray,
                                      fontSize: 13,
                                      height: 1.35,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              saved ? Icons.bookmark_rounded : Icons.bookmark_add_outlined,
                              color: saved ? C.orange : C.gray,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: en ? 'Practice this category' : '이 카테고리 연습하기',
                icon: Icons.school_rounded,
                color: C.orange,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PhrasePracticeScreen(
                      lang: widget.lang,
                      category: categories[selected],
                      phrases: current,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Practice screen for real-use Korean survival phrases.
class PhrasePracticeScreen extends StatefulWidget {
  const PhrasePracticeScreen({
    super.key,
    required this.lang,
    required this.category,
    required this.phrases,
  });

  final AppLang lang;
  final String category;
  final List<List<String>> phrases;

  @override
  State<PhrasePracticeScreen> createState() => _PhrasePracticeScreenState();
}

class _PhrasePracticeScreenState extends State<PhrasePracticeScreen> {
  int index = 0;
  bool revealed = false;
  final Set<int> learned = {};

  bool get en => widget.lang == AppLang.en;

  void nextPhrase() {
    setState(() {
      learned.add(index);
      if (index < widget.phrases.length - 1) {
        index++;
      } else {
        index = 0;
      }
      revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final phrase = widget.phrases[index];
    final progress = learned.length / widget.phrases.length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'Phrase practice' : '표현 연습',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en
                    ? 'Practice ${widget.category} phrases you can use in real situations.'
                    : '${widget.category} 상황에서 바로 쓸 표현을 연습합니다.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.category,
                          style: TextStyle(
                            color: Colors.white.withOpacity(.72),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${learned.length}/${widget.phrases.length}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.72),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        color: Colors.white,
                        backgroundColor: const Color(0x33FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      en ? 'Read it, reveal the meaning, then move to the next phrase.' : '문장을 읽고, 뜻을 확인한 뒤 다음 표현으로 넘어가세요.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        height: 1.25,
                        letterSpacing: -0.8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TossCard(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Practice card ${index + 1}' : '연습 카드 ${index + 1}',
                      style: const TextStyle(
                        color: C.gray,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      phrase[0],
                      style: const TextStyle(
                        color: C.black,
                        fontSize: 26,
                        height: 1.2,
                        letterSpacing: -0.8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: revealed
                          ? Container(
                              key: const ValueKey('revealed'),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: C.orangeSoft,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                phrase[1],
                                style: const TextStyle(
                                  color: C.orange,
                                  height: 1.4,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          : Container(
                              key: const ValueKey('hidden'),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: C.bg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                en ? 'Tap the button below to reveal the meaning.' : '아래 버튼을 눌러 뜻을 확인하세요.',
                                style: const TextStyle(
                                  color: C.gray,
                                  height: 1.4,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: revealed ? (en ? 'I know this. Next' : '알았어요. 다음') : (en ? 'Reveal meaning' : '뜻 보기'),
                icon: revealed ? Icons.arrow_forward_rounded : Icons.visibility_rounded,
                color: revealed ? C.green : C.orange,
                onTap: () {
                  if (revealed) {
                    nextPhrase();
                  } else {
                    setState(() => revealed = true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettlementRoadmapCard extends StatelessWidget {
  const SettlementRoadmapCard({
    super.key,
    required this.lang,
    required this.onTap,
  });

  final AppLang lang;
  final VoidCallback onTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: C.greenSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.route_rounded, color: C.green, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    en ? '7-day settlement roadmap' : '7일 정착 로드맵',
                    style: const TextStyle(
                      color: C.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    en ? 'Know what to do first, next, and later' : '먼저 할 일, 다음 할 일, 나중 할 일을 정리해요',
                    style: const TextStyle(
                      color: C.gray,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: C.gray),
          ],
        ),
      ),
    );
  }
}

class SettlementRoadmapScreen extends StatefulWidget {
  const SettlementRoadmapScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<SettlementRoadmapScreen> createState() => _SettlementRoadmapScreenState();
}

class _SettlementRoadmapScreenState extends State<SettlementRoadmapScreen> {
  late List<bool> done;

  bool get en => widget.lang == AppLang.en;

  @override
  void initState() {
    super.initState();
    done = [true, true, false, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    final roadmap = [
      [
        Icons.sim_card_rounded,
        en ? 'Day 1 · Set up phone number' : '1일차 · 휴대폰 번호 준비',
        en ? 'SIM or eSIM helps with identity checks, delivery, bank apps, and reservations.' : '유심·eSIM은 본인인증, 배달, 은행앱, 예약 서비스의 시작점입니다.',
      ],
      [
        Icons.credit_card_rounded,
        en ? 'Day 1 · Prepare transport' : '1일차 · 교통 준비',
        en ? 'Top up T-money and learn one route from home.' : 'T머니를 충전하고 집에서 자주 갈 경로 하나를 익혀요.',
      ],
      [
        Icons.location_on_rounded,
        en ? 'Day 2 · Save addresses' : '2일차 · 주소 저장',
        en ? 'Save home, school, workplace, and dormitory addresses for taxi and delivery.' : '택시와 배달을 위해 집, 학교, 회사, 기숙사 주소를 저장해요.',
      ],
      [
        Icons.restaurant_rounded,
        en ? 'Day 3 · Practice food ordering' : '3일차 · 음식 주문 연습',
        en ? 'Try a kiosk or delivery order with request notes.' : '키오스크나 배달앱에서 요청사항까지 포함해 주문해봐요.',
      ],
      [
        Icons.badge_rounded,
        en ? 'Day 5 · Check admin documents' : '5일차 · 행정 서류 점검',
        en ? 'Prepare ARC, bank, and visit-reservation documents before going outside.' : '외국인등록증, 은행, 방문예약에 필요한 서류를 미리 확인해요.',
      ],
      [
        Icons.contact_phone_rounded,
        en ? 'Day 7 · Safety setup' : '7일차 · 안전 설정',
        en ? 'Save emergency contacts and useful Korean phrases for urgent moments.' : '긴급 연락처와 위급 상황 한국어 표현을 저장해요.',
      ],
    ];

    final completed = done.where((v) => v).length;
    final progress = completed / done.length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? '7-day roadmap' : '7일 정착 로드맵',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en
                    ? 'A practical order of actions for your first week in Korea.'
                    : '한국 생활 첫 주에 필요한 행동을 순서대로 정리했습니다.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'First-week readiness' : '첫 주 준비도',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$completed/${done.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 11,
                        color: Colors.white,
                        backgroundColor: const Color(0x33FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      en
                          ? 'This roadmap connects missions, phrases, admin guides, and safety setup.'
                          : '이 로드맵은 미션, 표현, 행정 가이드, 안전 설정을 하나로 연결합니다.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Header(title: en ? 'Recommended order' : '추천 진행 순서', action: '${(progress * 100).round()}%'),
              ...List.generate(
                roadmap.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () => setState(() => done[i] = !done[i]),
                    borderRadius: BorderRadius.circular(28),
                    child: TossCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconBox(
                            icon: roadmap[i][0] as IconData,
                            color: done[i] ? C.green : C.blue,
                            bg: done[i] ? C.greenSoft : C.blueSoft,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  roadmap[i][1] as String,
                                  style: const TextStyle(
                                    color: C.black,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  roadmap[i][2] as String,
                                  style: const TextStyle(
                                    color: C.gray,
                                    fontSize: 13,
                                    height: 1.35,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            done[i] ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                            color: done[i] ? C.green : C.gray,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: en ? 'Open missions and continue' : '미션에서 이어서 진행하기',
                icon: Icons.flag_rounded,
                color: C.green,
                onTap: () => toast(context, en ? 'Use the mission tab to continue.' : '미션 탭에서 이어서 진행하세요.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.lang,
    this.onTap,
  });

  final AppLang lang;
  final VoidCallback? onTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final card = TossCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const IconBox(
                icon: Icons.person_rounded,
                color: C.blue,
                bg: C.blueSoft,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Alex Kim',
                      style: TextStyle(
                        color: C.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      en ? 'Day 12 in Korea' : '한국 정착 12일차',
                      style: const TextStyle(
                        color: C.gray,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const LevelBadge(),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                en ? 'To next level' : '다음 레벨까지',
                style: const TextStyle(
                  color: C.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                '620 / 1000 XP',
                style: TextStyle(
                  color: C.gray,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: .62,
              minHeight: 11,
              color: C.blue,
              backgroundColor: C.blueSoft,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: MetricBox(
                  label: en ? 'Points' : '포인트',
                  value: '3,200P',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MetricBox(
                  label: en ? 'Completed' : '완료 미션',
                  value: '12',
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (onTap == null) return card;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: card,
    );
  }
}

class IconBox extends StatelessWidget {
  const IconBox({
    super.key,
    required this.icon,
    required this.color,
    required this.bg,
  });

  final IconData icon;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: color, size: 28),
    );
  }
}

class LevelBadge extends StatelessWidget {
  const LevelBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: C.black,
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'Lv.3',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class MetricBox extends StatelessWidget {
  const MetricBox({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: C.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: C.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: C.gray,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: C.black,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
            ),
          ),
          if (action != null)
            Text(
              action!,
              style: const TextStyle(
                color: C.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
        ],
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
    required this.labels,
    required this.selected,
    required this.onTap,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(labels.length, (i) {
          final isSelected = i == selected;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => onTap(i),
              borderRadius: BorderRadius.circular(999),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? C.black : Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: isSelected
                      ? const [
                          BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 12,
                            offset: Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  labels[i],
                  style: TextStyle(
                    color: isSelected ? Colors.white : C.gray,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}



void openMission(
  BuildContext context,
  Mission mission,
  AppLang lang,
  ValueChanged<AppLang> onLangChanged,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MissionDetailScreen(
        mission: mission,
        lang: lang,
        onLangChanged: onLangChanged,
      ),
    ),
  );
}


class MissionCard extends StatelessWidget {
  const MissionCard({
    super.key,
    required this.mission,
    required this.lang,
    required this.onTap,
  });

  final Mission mission;
  final AppLang lang;
  final VoidCallback onTap;

  bool get guide => mission.type == MissionType.guide;
  Color get accent => guide ? C.orange : C.blue;
  Color get soft => guide ? C.orangeSoft : C.blueSoft;
  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: TossCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconBox(icon: mission.icon, color: accent, bg: soft),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${mission.category(lang)} · ${guide ? (en ? 'Guide' : '설명 가이드') : (en ? 'Verification' : '검증 미션')}',
                          style: TextStyle(
                            color: accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          mission.title(lang),
                          style: const TextStyle(
                            color: C.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          mission.desc(lang),
                          style: const TextStyle(
                            color: C.gray,
                            fontSize: 14,
                            height: 1.42,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RewardBox(
                reward: '+${mission.xp} XP · ${mission.point}P',
                status: mission.status(lang),
                accent: accent,
                label: en ? 'Reward' : '보상',
              ),
              if (mission.progress > 0) ...[
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: mission.progress,
                    minHeight: 8,
                    color: accent,
                    backgroundColor: soft,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class RewardBox extends StatelessWidget {
  const RewardBox({
    super.key,
    required this.reward,
    required this.status,
    required this.accent,
    required this.label,
  });

  final String reward;
  final String status;
  final Color accent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: C.bg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.card_giftcard_rounded,
            size: 19,
            color: C.blue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label $reward',
              style: const TextStyle(
                color: C.black,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class DoneTile extends StatelessWidget {
  const DoneTile({
    super.key,
    required this.title,
    required this.lang,
  });

  final String title;
  final AppLang lang;

  @override
  Widget build(BuildContext context) {
    return ListRow(
      icon: Icons.check_rounded,
      iconColor: C.green,
      iconBg: C.greenSoft,
      title: title,
      subtitle: lang == AppLang.en ? 'Completed · Reward received' : '완료됨 · 보상 지급 완료',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CompletedMissionsScreen(lang: lang),
        ),
      ),
    );
  }
}

class CompletedMissionsScreen extends StatelessWidget {
  const CompletedMissionsScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final completed = [
      [
        Icons.train_rounded,
        en ? 'Check subway routes' : '지하철 노선 확인하기',
        '+20 XP · 200P',
        en ? 'Transport basics completed' : '교통 기본 미션 완료',
      ],
      [
        Icons.recycling_rounded,
        en ? 'Learn recycling rules' : '분리수거 방법 익히기',
        '+20 XP · 200P',
        en ? 'Daily life guide completed' : '생활 가이드 완료',
      ],
      [
        Icons.store_rounded,
        en ? 'Buy something at a convenience store' : '편의점에서 상품 구매하기',
        '+30 XP · 300P',
        en ? 'Practical purchase mission' : '실생활 구매 미션 완료',
      ],
      [
        Icons.restaurant_rounded,
        en ? 'Order with a kiosk' : '키오스크로 주문하기',
        '+40 XP · 400P',
        en ? 'Food mission verified' : '음식 미션 인증 완료',
      ],
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'Completed missions' : '완료한 미션',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en
                    ? 'Review completed missions and rewards earned.'
                    : '완료한 미션과 획득한 보상을 한눈에 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Mission archive' : '미션 아카이브',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '12',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      en ? 'missions completed · 1,100P earned' : '개 미션 완료 · 1,100P 획득',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Header(title: en ? 'Recent completions' : '최근 완료 내역'),
              ...completed.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TossCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconBox(
                          icon: item[0] as IconData,
                          color: C.green,
                          bg: C.greenSoft,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item[1] as String,
                                style: const TextStyle(
                                  color: C.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item[3] as String,
                                style: const TextStyle(
                                  color: C.gray,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item[2] as String,
                          style: const TextStyle(
                            color: C.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.board,
    required this.title,
    required this.meta,
    required this.onTap,
  });

  final String board;
  final String title;
  final String meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListRow(
      textIcon: board.substring(0, 1),
      iconColor: C.blue,
      iconBg: C.blueSoft,
      title: title,
      subtitle: meta,
      onTap: onTap,
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListRow(
      icon: icon,
      iconColor: C.blue,
      iconBg: C.blueSoft,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}

class ListRow extends StatelessWidget {
  const ListRow({
    super.key,
    this.icon,
    this.textIcon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData? icon;
  final String? textIcon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: TossCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: textIcon != null
                      ? Text(
                          textIcon!,
                          style: TextStyle(
                            color: iconColor,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      : Icon(icon, color: iconColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: C.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: C.gray,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: C.gray),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryBox extends StatelessWidget {
  const SummaryBox({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TossCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: C.blue),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              color: C.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: C.gray,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return TossCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: C.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: C.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: C.gray,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.color = C.black,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 25),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LangButton extends StatelessWidget {
  const LangButton({
    super.key,
    required this.lang,
    required this.onTap,
  });

  final AppLang lang;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language_rounded, size: 19, color: C.black),
            const SizedBox(width: 6),
            Text(
              lang == AppLang.ko ? 'KO' : 'EN',
              style: const TextStyle(
                color: C.black,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class MissionDetailScreen extends StatelessWidget {
  const MissionDetailScreen({
    super.key,
    required this.mission,
    required this.lang,
    required this.onLangChanged,
  });

  final Mission mission;
  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final isVerify = mission.type == MissionType.verify;
    final steps = mission.steps(lang);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Spacer(),
                  LangButton(
                    lang: lang,
                    onTap: () => showLanguageSheet(context, lang, onLangChanged),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            mission.category(lang),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '+${mission.xp} XP · ${mission.point}P',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.72),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    IconBox(
                      icon: mission.icon,
                      color: Colors.white,
                      bg: Colors.white.withOpacity(.14),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      mission.title(lang),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        height: 1.15,
                        letterSpacing: -1.1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      mission.desc(lang),
                      style: TextStyle(
                        color: Colors.white.withOpacity(.72),
                        fontSize: 15,
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Text(
                          mission.status(lang),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${(mission.progress * 100).round()}%',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.72),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: mission.progress,
                        minHeight: 10,
                        color: Colors.white,
                        backgroundColor: const Color(0x33FFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
              Header(title: en ? 'Practical phrase' : '실전 표현'),
              MissionPracticalPhraseCard(
                mission: mission,
                lang: lang,
              ),
              Header(title: en ? 'Steps' : '진행 단계'),
              ...List.generate(
                steps.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TossCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: C.blueSoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: const TextStyle(
                                color: C.blue,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            steps[i],
                            style: const TextStyle(
                              color: C.black,
                              height: 1.45,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: isVerify
                    ? (en ? 'Start verification' : '인증 시작하기')
                    : (en ? 'Mark guide as read' : '가이드 읽음 처리'),
                icon: isVerify ? Icons.camera_alt_rounded : Icons.check_rounded,
                color: isVerify ? C.blue : C.green,
                onTap: () {
                  if (isVerify) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyScreen(
                          mission: mission,
                          lang: lang,
                        ),
                      ),
                    );
                  } else {
                    toast(
                      context,
                      en ? 'Guide marked as read.' : '가이드를 읽음 처리했습니다.',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MissionPracticalPhraseCard extends StatelessWidget {
  const MissionPracticalPhraseCard({
    super.key,
    required this.mission,
    required this.lang,
  });

  final Mission mission;
  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final title = mission.title(lang);
    final lower = title.toLowerCase();

    IconData icon = Icons.tips_and_updates_rounded;
    Color color = C.blue;
    Color bg = C.blueSoft;
    String phrase = en ? 'Please help me with this.' : '이것 좀 도와주세요.';
    String desc = en
        ? 'Use this when you need help during the mission.'
        : '미션 중 도움이 필요할 때 바로 사용할 수 있는 표현입니다.';

    if (title.contains('택시') || lower.contains('taxi')) {
      icon = Icons.local_taxi_rounded;
      color = C.orange;
      bg = C.orangeSoft;
      phrase = en ? 'Please go to this address.' : '이 주소로 가주세요.';
      desc = en ? 'Show this to the driver if communication is difficult.' : '말이 잘 통하지 않을 때 기사님께 보여주면 좋습니다.';
    } else if (title.contains('배달') || lower.contains('delivery')) {
      icon = Icons.delivery_dining_rounded;
      color = C.orange;
      bg = C.orangeSoft;
      phrase = en ? 'Please leave it at the door.' : '문 앞에 놓아주세요.';
      desc = en ? 'Useful as a delivery request note.' : '배달 요청사항에 바로 사용할 수 있습니다.';
    } else if (title.contains('병원') || lower.contains('clinic') || lower.contains('pharmacy')) {
      icon = Icons.local_hospital_rounded;
      color = C.green;
      bg = C.greenSoft;
      phrase = en ? 'I have a fever.' : '열이 있어요.';
      desc = en ? 'Use this at a clinic or pharmacy counter.' : '병원 접수나 약국에서 사용할 수 있습니다.';
    } else if (title.contains('긴급') || lower.contains('emergency')) {
      icon = Icons.contact_phone_rounded;
      color = C.green;
      bg = C.greenSoft;
      phrase = en ? 'Please call 119.' : '119에 전화해주세요.';
      desc = en ? 'Keep this ready for urgent situations.' : '긴급 상황에서 바로 보여줄 수 있도록 준비하세요.';
    } else if (title.contains('키오스크') || lower.contains('kiosk')) {
      icon = Icons.restaurant_rounded;
      color = C.orange;
      bg = C.orangeSoft;
      phrase = en ? 'Can I pay by card?' : '카드 결제 되나요?';
      desc = en ? 'Useful when ordering or paying in stores.' : '매장에서 주문하거나 결제할 때 유용합니다.';
    } else if (title.contains('T머니') || lower.contains('t-money')) {
      icon = Icons.credit_card_rounded;
      color = C.blue;
      bg = C.blueSoft;
      phrase = en ? 'Please charge 10,000 won.' : '만 원 충전해주세요.';
      desc = en ? 'Use this at a convenience store or station machine.' : '편의점이나 지하철역 충전기에서 사용할 수 있습니다.';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TossCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBox(icon: icon, color: color, bg: bg),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    desc,
                    style: const TextStyle(
                      color: C.gray,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                phrase,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class VerifyScreen extends StatefulWidget {
  const VerifyScreen({
    super.key,
    required this.mission,
    required this.lang,
  });

  final Mission mission;
  final AppLang lang;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  int stage = 0;
  bool busy = false;

  bool get en => widget.lang == AppLang.en;

  Future<void> nextStage() async {
    if (busy) return;

    if (stage < 2) {
      setState(() => stage += 1);
      toast(
        context,
        stage == 1
            ? (en ? 'Photo captured.' : '사진 촬영이 완료되었습니다.')
            : (en ? 'Location confirmed.' : '위치 확인이 완료되었습니다.'),
      );
      return;
    }

    if (stage == 2) {
      setState(() {
        busy = true;
        stage = 3;
      });
      await Future.delayed(const Duration(milliseconds: 1200));
      if (!mounted) return;
      setState(() {
        busy = false;
        stage = 4;
      });
      return;
    }

    completeSheet(context, widget.mission, widget.lang);
  }

  @override
  Widget build(BuildContext context) {
    final title = en ? 'Smart verification' : '스마트 인증';
    final buttonLabel = switch (stage) {
      0 => en ? 'Take photo' : '사진 촬영하기',
      1 => en ? 'Confirm location' : '위치 확인하기',
      2 => en ? 'Start AI check' : 'AI 검증 시작',
      3 => en ? 'Checking...' : '검증 중...',
      _ => en ? 'Receive reward' : '보상 받기',
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: const TextStyle(
                  color: C.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.mission.title(widget.lang),
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      VerificationHeroCard(stage: stage, busy: busy, lang: widget.lang),
                      const SizedBox(height: 14),
                      VerificationStepTile(
                        number: 1,
                        title: en ? 'Photo proof' : '사진 인증',
                        subtitle: en ? 'Capture receipt or completed screen.' : '영수증 또는 완료 화면을 촬영합니다.',
                        done: stage >= 1,
                        active: stage == 0,
                      ),
                      VerificationStepTile(
                        number: 2,
                        title: en ? 'Location check' : '위치 확인',
                        subtitle: en ? 'Check whether proof was captured nearby.' : '근처에서 촬영된 인증인지 확인합니다.',
                        done: stage >= 2,
                        active: stage == 1,
                      ),
                      VerificationStepTile(
                        number: 3,
                        title: en ? 'AI validation' : 'AI 검증',
                        subtitle: en ? 'Detect whether the proof matches this mission.' : '인증 사진이 미션 조건과 맞는지 판별합니다.',
                        done: stage >= 4,
                        active: stage == 2 || stage == 3,
                      ),
                      VerificationStepTile(
                        number: 4,
                        title: en ? 'Reward approval' : '보상 승인',
                        subtitle: en ? 'Reward is ready after verification.' : '검증이 끝나면 보상을 받을 수 있습니다.',
                        done: stage >= 4,
                        active: stage == 4,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: buttonLabel,
                icon: stage >= 4 ? Icons.card_giftcard_rounded : Icons.verified_rounded,
                color: stage >= 4 ? C.green : C.black,
                onTap: busy ? () {} : nextStage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerificationHeroCard extends StatelessWidget {
  const VerificationHeroCard({
    super.key,
    required this.stage,
    required this.busy,
    required this.lang,
  });

  final int stage;
  final bool busy;
  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final approved = stage >= 4;
    final checking = stage == 3;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: approved ? C.green : C.black,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: checking
                    ? const Padding(
                        padding: EdgeInsets.all(15),
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        approved ? Icons.check_rounded : Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
              ),
              const Spacer(),
              Text(
                approved ? (en ? 'Approved' : '승인 완료') : (en ? 'Secure check' : '안전 검증'),
                style: TextStyle(
                  color: Colors.white.withOpacity(.72),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            approved
                ? (en ? 'Verification completed' : '인증이 완료되었습니다')
                : checking
                    ? (en ? 'AI is checking your proof' : 'AI가 인증 자료를 확인 중입니다')
                    : (en ? 'Submit proof in four simple steps' : '4단계로 안전하게 인증해요'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              height: 1.22,
              letterSpacing: -0.8,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            approved
                ? (en ? 'The mission reward is ready to be added.' : '미션 보상을 지급할 준비가 완료되었습니다.')
                : (en ? 'Photo, location, time, and mission match are checked before reward approval.' : '사진, 위치, 시간, 미션 일치 여부를 확인한 뒤 보상이 승인됩니다.'),
            style: TextStyle(
              color: Colors.white.withOpacity(.72),
              height: 1.45,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationStepTile extends StatelessWidget {
  const VerificationStepTile({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.done,
    required this.active,
  });

  final int number;
  final String title;
  final String subtitle;
  final bool done;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = done ? C.green : active ? C.blue : C.gray;
    final bg = done ? C.greenSoft : active ? C.blueSoft : C.bg;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TossCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: done
                    ? const Icon(Icons.check_rounded, color: C.green)
                    : Text(
                        '$number',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: C.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: C.gray,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void openPost(BuildContext context, String title, AppLang lang) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PostDetailScreen(title: title, lang: lang),
    ),
  );
}

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.title,
    required this.lang,
  });

  final String title;
  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  color: C.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                en ? 'Alex Kim · Lv.3 · just now' : 'Alex Kim · Lv.3 · 방금 전',
                style: const TextStyle(
                  color: C.gray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              TossCard(
                child: Text(
                  en
                      ? 'This is a sample post screen for checking the final community design. Reply, like, and report flows can be connected later.'
                      : '처음 한국 생활을 시작하는 외국인 입장에서 헷갈릴 수 있는 내용을 질문하는 예시 화면입니다. 댓글과 추천, 신고 버튼까지 디자인 확인이 가능하도록 구성했습니다.',
                  style: const TextStyle(
                    color: C.black,
                    height: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PostActionBar(lang: lang),
              Header(title: en ? 'Replies' : '댓글'),
              TossCard(
                padding: const EdgeInsets.all(16),
                child: Text(
                  en
                      ? 'Mina · You can also top up at convenience stores.'
                      : 'Mina · 편의점에서도 가능해요. 직원에게 T-money charge라고 말하면 됩니다.',
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: en ? 'Write reply' : '댓글 작성하기',
                icon: Icons.chat_bubble_rounded,
                onTap: () => toast(
                  context,
                  en ? 'Reply input opened.' : '댓글 입력창을 엽니다.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PostActionBar extends StatefulWidget {
  const PostActionBar({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<PostActionBar> createState() => _PostActionBarState();
}

class _PostActionBarState extends State<PostActionBar> {
  bool liked = false;
  bool saved = false;

  bool get en => widget.lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MiniActionButton(
            icon: liked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
            label: liked ? (en ? 'Liked' : '추천됨') : (en ? 'Like' : '추천'),
            active: liked,
            onTap: () => setState(() => liked = !liked),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: MiniActionButton(
            icon: saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            label: saved ? (en ? 'Saved' : '저장됨') : (en ? 'Save' : '저장'),
            active: saved,
            onTap: () => setState(() => saved = !saved),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: MiniActionButton(
            icon: Icons.report_gmailerrorred_rounded,
            label: en ? 'Report' : '신고',
            active: false,
            onTap: () => toast(context, en ? 'Report received.' : '신고가 접수되었습니다.'),
          ),
        ),
      ],
    );
  }
}

class MiniActionButton extends StatelessWidget {
  const MiniActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: active ? C.blueSoft : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: active ? C.blueSoft : C.light),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: active ? C.blue : C.gray),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: active ? C.blue : C.gray,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WritePostScreen extends StatelessWidget {
  const WritePostScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 20),
              Text(
                en ? 'Write post' : '글쓰기',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 24),
              FilterBar(
                labels: en ? const ['Free board', 'Q&A'] : const ['자유게시판', 'Q&A'],
                selected: 0,
                onTap: (_) {},
              ),
              const SizedBox(height: 18),
              TossTextField(hint: en ? 'Title' : '제목을 입력하세요'),
              const SizedBox(height: 12),
              TossTextField(
                hint: en ? 'Write something' : '내용을 입력하세요',
                maxLines: 8,
              ),
              const SizedBox(height: 22),
              PrimaryButton(
                label: en ? 'Publish' : '등록하기',
                icon: Icons.check_rounded,
                onTap: () => toast(
                  context,
                  en ? 'Post published as a prototype.' : '게시글이 등록된 것처럼 처리했습니다.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TossTextField extends StatelessWidget {
  const TossTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
  });

  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: C.blue, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

void completeSheet(BuildContext context, Mission mission, AppLang lang) {
  final en = lang == AppLang.en;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: C.greenSoft,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: C.green,
              size: 34,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            en ? 'Mission complete!' : '미션 완료!',
            style: const TextStyle(
              color: C.black,
              fontSize: 27,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            en
                ? 'Reward +${mission.xp} XP · ${mission.point}P will be added.'
                : '보상 +${mission.xp} XP · ${mission.point}P가 지급됩니다.',
            style: const TextStyle(
              color: C.gray,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22),
          PrimaryButton(
            label: en ? 'OK' : '확인',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    ),
  );
}

class PointHistoryScreen extends StatelessWidget {
  const PointHistoryScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final items = [
      [
        en ? 'T-money top-up mission' : 'T머니 카드 충전하기',
        '+300P',
        en ? 'Verification reward' : '인증 보상',
      ],
      [
        en ? 'Kiosk order mission' : '키오스크로 주문하기',
        '+400P',
        en ? 'Verification reward' : '인증 보상',
      ],
      [
        en ? 'ARC guide completed' : '외국인등록증 가이드 확인',
        '+100P',
        en ? 'Guide reward' : '가이드 보상',
      ],
      [
        en ? 'Daily check-in' : '오늘의 출석',
        '+50P',
        en ? 'Daily bonus' : '일일 보너스',
      ],
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'Point history' : '포인트 내역',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en ? 'See where your points came from.' : '포인트를 어디서 얻었는지 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              TossCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Current points' : '현재 포인트',
                      style: const TextStyle(
                        color: C.gray,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '3,200P',
                      style: TextStyle(
                        color: C.black,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: const LinearProgressIndicator(
                        value: .72,
                        minHeight: 10,
                        color: C.blue,
                        backgroundColor: C.blueSoft,
                      ),
                    ),
                  ],
                ),
              ),
              Header(title: en ? 'Recent activity' : '최근 적립 내역'),
              ...items.map(
                (item) => ListRow(
                  icon: Icons.add_rounded,
                  iconColor: C.green,
                  iconBg: C.greenSoft,
                  title: item[0],
                  subtitle: '${item[2]} · ${item[1]}',
                  onTap: () => toast(context, item[1]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BadgeCollectionScreen extends StatelessWidget {
  const BadgeCollectionScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final badges = [
      [
        Icons.train_rounded,
        en ? 'Transit starter' : '교통 적응자',
        en ? 'Completed first transport mission' : '교통 미션 첫 완료',
      ],
      [
        Icons.restaurant_rounded,
        en ? 'Kiosk challenger' : '키오스크 도전자',
        en ? 'Tried a kiosk order' : '키오스크 주문 완료',
      ],
      [
        Icons.badge_rounded,
        en ? 'Admin learner' : '행정 준비생',
        en ? 'Read an admin guide' : '행정 가이드 확인',
      ],
      [
        Icons.language_rounded,
        en ? 'Local explorer' : '생활 탐험가',
        en ? 'Used local life tips' : '생활 정보 활용',
      ],
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'Badges' : '뱃지 컬렉션',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en ? 'Badges earned from settlement missions.' : '정착 미션을 통해 얻은 뱃지를 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Header(title: en ? 'Earned badges' : '획득한 뱃지', action: '4'),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: badges.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: .92,
                ),
                itemBuilder: (context, index) {
                  final badge = badges[index];

                  return TossCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconBox(
                          icon: badge[0] as IconData,
                          color: C.orange,
                          bg: C.orangeSoft,
                        ),
                        const Spacer(),
                        Text(
                          badge[1] as String,
                          style: const TextStyle(
                            color: C.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          badge[2] as String,
                          style: const TextStyle(
                            color: C.gray,
                            fontSize: 12,
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final posts = [
      [
        en ? 'My first time using the Korean subway' : '처음 한국 지하철을 타본 후기',
        en ? 'Free board · 2 replies' : '자유게시판 · 댓글 2',
      ],
      [
        en ? 'Where can I top up T-money?' : 'T머니 충전은 어디서 할 수 있나요?',
        en ? 'Q&A · 3 replies' : 'Q&A · 댓글 3',
      ],
      [
        en ? 'Useful words at convenience stores' : '편의점에서 자주 쓰는 말 정리',
        en ? 'Free board · 1 reply' : '자유게시판 · 댓글 1',
      ],
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'My posts' : '내가 쓴 글',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en ? 'Posts and questions you wrote.' : '내가 작성한 게시글과 질문을 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Header(title: en ? 'Recent posts' : '최근 작성 글', action: '${posts.length}'),
              ...posts.map(
                (post) => PostTile(
                  board: post[1].contains('Q&A') ? 'Q&A' : 'FREE',
                  title: post[0],
                  meta: post[1],
                  onTap: () => openPost(context, post[0], lang),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showLanguageSheet(
  BuildContext context,
  AppLang current,
  ValueChanged<AppLang> onChanged,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            current == AppLang.en ? 'Language' : '언어 선택',
            style: const TextStyle(
              color: C.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          MenuTile(
            icon: current == AppLang.ko
                ? Icons.check_rounded
                : Icons.language_rounded,
            title: '한국어',
            subtitle: current == AppLang.ko ? '현재 선택됨' : 'Korean',
            onTap: () {
              onChanged(AppLang.ko);
              Navigator.pop(context);
            },
          ),
          MenuTile(
            icon: current == AppLang.en
                ? Icons.check_rounded
                : Icons.language_rounded,
            title: 'English',
            subtitle: current == AppLang.en ? 'Selected' : '영어로 변경',
            onTap: () {
              onChanged(AppLang.en);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
class PassportScreen extends StatelessWidget {
  const PassportScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final areas = [
      [Icons.train_rounded, en ? 'Transport' : '교통', '70%', C.blue, C.blueSoft],
      [Icons.restaurant_rounded, en ? 'Food' : '음식', '45%', C.green, C.greenSoft],
      [Icons.badge_rounded, en ? 'Admin' : '행정', '30%', C.orange, C.orangeSoft],
      [Icons.home_rounded, en ? 'Daily life' : '생활', '55%', C.blue, C.blueSoft],
    ];

    final next = [
      en ? 'Top up a T-money card' : 'T머니 카드 충전하기',
      en ? 'Complete an admin guide' : '행정 가이드 확인하기',
      en ? 'Write your first community post' : '커뮤니티 첫 글 작성하기',
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'K-Life Passport' : 'K-라이프 패스포트',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en ? 'A practical settlement map built from your missions.' : '미션 기록을 바탕으로 한국 생활 적응도를 보여주는 실용 지표입니다.',
                style: const TextStyle(color: C.gray, fontSize: 15, height: 1.4, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 24, offset: Offset(0, 12))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(en ? 'Settlement readiness' : '정착 준비도', style: TextStyle(color: Colors.white.withValues(alpha: .72), fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text('58%', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, letterSpacing: -1.5)),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: const LinearProgressIndicator(value: .58, minHeight: 11, color: Colors.white, backgroundColor: Color(0x33FFFFFF)),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      en ? 'You are ready for basic transport and daily tasks. Admin missions need more progress.' : '기본 교통과 생활 미션은 안정적입니다. 행정 가이드 진행률을 더 높이면 좋습니다.',
                      style: TextStyle(color: Colors.white.withValues(alpha: .7), height: 1.45, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Header(title: en ? 'Readiness by area' : '분야별 적응도'),
              ...areas.map(
                (area) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TossCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconBox(icon: area[0] as IconData, color: area[3] as Color, bg: area[4] as Color),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(area[1] as String, style: const TextStyle(color: C.black, fontWeight: FontWeight.w900)),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: LinearProgressIndicator(
                                  value: double.parse((area[2] as String).replaceAll('%', '')) / 100,
                                  minHeight: 8,
                                  color: area[3] as Color,
                                  backgroundColor: area[4] as Color,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(area[2] as String, style: const TextStyle(color: C.black, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                ),
              ),
              Header(title: en ? 'Next best actions' : '다음 추천 행동'),
              ...next.map(
                (title) => ListRow(
                  icon: Icons.arrow_forward_rounded,
                  iconColor: C.blue,
                  iconBg: C.blueSoft,
                  title: title,
                  subtitle: en ? 'Recommended to improve readiness' : '정착 준비도를 높이기 위한 추천 항목',
                  onTap: () => toast(context, en ? 'Recommendation selected.' : '추천 항목을 선택했습니다.'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminInfoPanel extends StatelessWidget {
  const AdminInfoPanel({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AdminMiniCard(
                icon: Icons.schedule_rounded,
                title: en ? 'Time' : '소요 시간',
                value: en ? '1-2 weeks' : '1~2주',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AdminMiniCard(
                icon: Icons.payments_rounded,
                title: en ? 'Fee' : '수수료',
                value: en ? 'About 30,000 KRW' : '약 3만원',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TossCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.fact_check_rounded, color: C.orange),
                  const SizedBox(width: 8),
                  Text(
                    en ? 'Before you visit' : '방문 전 체크리스트',
                    style: const TextStyle(
                      color: C.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AdminCheckRow(text: en ? 'Passport and ID photo prepared' : '여권과 증명사진 준비'),
              AdminCheckRow(text: en ? 'Visit reservation completed' : '방문 예약 완료'),
              AdminCheckRow(text: en ? 'Address and contact number checked' : '주소와 연락처 확인'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: C.orangeSoft,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: C.orange),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  en
                      ? 'Tip: Office requirements can differ by region. Check the latest notice before visiting.'
                      : '팁: 지역과 기관에 따라 요구 서류가 다를 수 있으므로 방문 전 최신 안내를 확인하세요.',
                  style: const TextStyle(
                    color: C.black,
                    height: 1.45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AdminMiniCard extends StatelessWidget {
  const AdminMiniCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TossCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: C.orange),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: C.gray,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: C.black,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminCheckRow extends StatelessWidget {
  const AdminCheckRow({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: C.greenSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.check_rounded, color: C.green, size: 16),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: C.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}