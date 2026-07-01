part of '../../../main.dart';

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
                      color: Color(0x1F0F1E3A),
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
                        color: Colors.white.withValues(alpha: .72),
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
                        color: Colors.white.withValues(alpha: .72),
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
                            color: done[i] ? C.blue : C.blue,
                            bg: done[i] ? C.blueSoft : C.blueSoft,
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
                            color: done[i] ? C.blue : C.gray,
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
                color: C.blue,
                onTap: () => toast(context, en ? 'Use the mission tab to continue.' : '미션 탭에서 이어서 진행하세요.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
