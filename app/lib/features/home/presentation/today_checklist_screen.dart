part of '../../../main.dart';

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
                  color: percent == 100 ? C.blue : C.black,
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
                      en ? 'Daily readiness' : '오늘의 준비도',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .72),
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
                        color: Colors.white.withValues(alpha: .72),
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
                            color: checked[i] ? C.blue : C.blue,
                            bg: checked[i] ? C.blueSoft : C.blueSoft,
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
                              color: checked[i] ? C.blue : C.gray,
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
                color: percent == 100 ? C.blue : C.blue,
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
