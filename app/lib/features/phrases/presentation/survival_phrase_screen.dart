part of '../../../main.dart';

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
        ? ['Taxi', 'Delivery', 'Clinic', 'Bank', 'Emergency']
        : ['택시', '배달', '병원', '은행', '긴급'];

    final phrases = [
      [
        [en ? 'Please go to this address.' : '이 주소로 가주세요.', en ? 'Show this to a taxi driver when the destination is hard to pronounce.' : '주소 발음이 어렵거나 길 때 기사님께 화면을 보여주세요.'],
        [en ? 'Please stop near the entrance.' : '입구 근처에서 세워주세요.', en ? 'Use this when you want to get off close to a building entrance.' : '정확한 건물 앞이 아니라 입구 근처에서 내리고 싶을 때 사용해요.'],
        [en ? 'Can I pay by card?' : '카드 결제 되나요?', en ? 'Useful before getting out of the taxi.' : '카드 결제가 되는지 미리 확인하고 싶을 때 사용해요.'],
        [en ? 'Please open the trunk.' : '트렁크 열어주세요.', en ? 'Useful when you have luggage.' : '캐리어나 큰 짐이 있을 때 기사님께 보여주세요.'],
      ],
      [
        [en ? 'Please leave it at the door.' : '문 앞에 놓아주세요.', en ? 'Use this as a delivery request note.' : '배달앱 요청사항에 그대로 넣기 좋은 문장입니다.'],
        [en ? 'Please call me when you arrive.' : '도착하면 전화해주세요.', en ? 'Useful when the entrance is hard to find.' : '공동현관, 원룸, 기숙사처럼 위치 설명이 필요할 때 좋아요.'],
        [en ? 'Please do not make it spicy.' : '맵지 않게 해주세요.', en ? 'Use this for restaurants, kiosks, and delivery apps.' : '매운 음식을 피하고 싶을 때 식당이나 배달 요청사항에 사용해요.'],
        [en ? 'Please include disposable utensils.' : '일회용 수저 넣어주세요.', en ? 'Useful for delivery orders.' : '수저가 필요한 경우 배달 요청사항에 그대로 넣으세요.'],
      ],
      [
        [en ? 'I have a fever and a sore throat.' : '열이 나고 목이 아파요.', en ? 'A clear symptom sentence for clinic reception.' : '접수할 때 증상을 짧게 설명해야 할 때 보여주세요.'],
        [en ? 'I need medicine for stomach pain.' : '배 아픈 약이 필요해요.', en ? 'Useful at a pharmacy.' : '처방전 없이 약국에서 증상을 설명할 때 사용할 수 있어요.'],
        [en ? 'How should I take this medicine?' : '이 약은 어떻게 먹어야 하나요?', en ? 'Ask this when receiving medicine.' : '하루 몇 번, 식전/식후 복용인지 확인할 때 꼭 물어보세요.'],
        [en ? 'Do you accept national health insurance?' : '건강보험 적용되나요?', en ? 'Useful when checking payment at clinics.' : '접수하거나 결제하기 전에 보험 적용 여부를 확인할 때 사용해요.'],
      ],
      [
        [en ? 'I would like to open a bank account.' : '통장을 만들고 싶어요.', en ? 'Use this at the bank information desk.' : '은행 안내 데스크나 번호표를 뽑기 전에 보여주기 좋아요.'],
        [en ? 'What documents do I need?' : '필요한 서류가 무엇인가요?', en ? 'Useful before waiting in line.' : '오래 기다리기 전에 서류가 맞는지 확인할 때 사용해요.'],
        [en ? 'I need a debit card.' : '체크카드가 필요해요.', en ? 'Use this when opening an account.' : '통장을 만들 때 체크카드도 같이 신청하고 싶을 때 사용해요.'],
        [en ? 'Can I use mobile banking?' : '모바일뱅킹 사용할 수 있나요?', en ? 'Useful for app setup and identity verification.' : '은행 앱 로그인, 이체, 본인인증이 가능한지 확인할 때 사용해요.'],
      ],
      [
        [en ? 'Please help me.' : '도와주세요.', en ? 'Use this first in urgent situations.' : '상황 설명이 어렵더라도 가장 먼저 보여줄 수 있는 문장입니다.'],
        [en ? 'Please call 119.' : '119에 전화해주세요.', en ? 'For medical emergency, fire, or rescue.' : '아프거나 다쳤거나 화재·구조 도움이 필요할 때 사용해요.'],
        [en ? 'Please call the police.' : '경찰을 불러주세요.', en ? 'Use this when you need police help.' : '위험하거나 신고가 필요한 상황에서 주변 사람에게 보여주세요.'],
        [en ? 'I do not speak Korean well.' : '한국어를 잘 못해요.', en ? 'Useful when asking someone to speak slowly or help translate.' : '상대방에게 천천히 말해달라고 하거나 번역 도움을 받을 때 사용해요.'],
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
                      en ? 'Quick use mode' : '빠른 사용 모드',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .72),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      en ? 'Tap a phrase to save it, or copy it to show someone.' : '저장하거나 복사해서 기사님, 직원, 약사에게 바로 보여주세요.',
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
                          ? 'These phrases are written for real situations: taxis, delivery, clinics, banks, and emergencies.'
                          : '발음이 어렵거나 급할 때 화면을 보여주는 방식으로 사용할 수 있어요.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .72),
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
                          color: saved ? C.blueSoft : Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: saved ? C.blueSoft : Colors.white),
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
                              color: saved ? C.blue : C.blue,
                              bg: saved ? Colors.white : C.blueSoft,
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
                              color: saved ? C.blue : C.gray,
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
                label: en ? 'Practice with flashcards' : '플래시카드로 연습하기',
                icon: Icons.school_rounded,
                color: C.blue,
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
