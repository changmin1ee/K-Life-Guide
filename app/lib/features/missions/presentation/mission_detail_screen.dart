part of '../../../main.dart';

class MissionDetailScreen extends StatefulWidget {
  const MissionDetailScreen({
    super.key,
    required this.mission,
    required this.lang,
    required this.onLangChanged,
  });

  final Mission mission;
  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<MissionDetailScreen> createState() => _MissionDetailScreenState();
}

class _MissionDetailScreenState extends State<MissionDetailScreen> {
  bool _busy = false;
  // 'AVAILABLE' | 'IN_PROGRESS' | 'COMPLETED'
  late String _status;

  bool get en => widget.lang == AppLang.en;
  Mission get mission => widget.mission;

  @override
  void initState() {
    super.initState();
    // 완료 여부: userProgress OR API koStatus 기준 (서버 재시작 후 userProgress 초기화 대응)
    if (isMissionCompleted(mission) || mission.koStatus == '완료') {
      _status = 'COMPLETED';
    } else if (mission.koStatus == '진행 중') {
      _status = 'IN_PROGRESS';
    } else {
      _status = 'AVAILABLE';
    }
  }

  /// 미션 수락 (start)
  Future<void> _acceptMission() async {
    if (_busy || mission.id == null) return;
    setState(() => _busy = true);
    try {
      final res = await ApiClient.dio.post('/api/missions/${mission.id}/start');
      if (res.data['isSuccess'] == true) {
        setState(() => _status = 'IN_PROGRESS');
      }
      // isSuccess false인 경우: 409(이미완료) 등 → 서버 응답은 정상이지만 실패
      // Dio가 4xx를 예외로 던지므로 여기 도달하면 2xx 성공
    } catch (e) {
      // 실패 시 상태 변경하지 않음 — 낙관 처리 제거
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(en ? 'Failed to accept mission.' : '미션 수락에 실패했습니다.')),
        );
      }
    }
    setState(() => _busy = false);
  }

  /// GUIDE 미션 완료
  Future<void> _completeGuide() async {
    if (_busy || mission.id == null) return;
    setState(() => _busy = true);
    try {
      final res = await ApiClient.dio.post(
        '/api/missions/${mission.id}/complete',
        data: {'proofImageUrl': null},
      );
      if (res.data['isSuccess'] == true) {
        final result = res.data['result'] as Map<String, dynamic>;
        userProgress.value = UserProgressState(
          points: result['newTotalPoints'] ?? userProgress.value.points,
          xp: result['newTotalXp'] ?? userProgress.value.xp,
          completedMissionTitles: {
            ...userProgress.value.completedMissionTitles,
            mission.koTitle,
          },
        );
        missionListNotifier.value = [];
        setState(() => _status = 'COMPLETED');
      }
    } on DioException catch (e) {
      final code = e.response?.data?['code'] as String?;
      if (code == 'MISSION409') {
        // 이미 완료된 미션: 완료 상태로 전환
        missionListNotifier.value = [];
        setState(() => _status = 'COMPLETED');
      } else {
        // 그 외 오류 (404 등): 메시지 표시
        final msg = e.response?.data?['message'] as String?;
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg ?? (en ? 'Failed to complete mission.' : '미션 완료에 실패했습니다.')),
            ),
          );
        }
      }
    }
    setState(() => _busy = false);
    if (!mounted) return;
    if (_status == 'COMPLETED') {
      completeSheet(context, mission, widget.lang);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isVerify = mission.type == MissionType.verify;
    final steps = mission.steps(widget.lang);

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
                    lang: widget.lang,
                    onTap: () => showLanguageSheet(context, widget.lang, widget.onLangChanged),
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
                      color: Color(0x1F0F1E3A),
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
                            color: Colors.white.withValues(alpha: .12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            mission.category(widget.lang),
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
                            color: Colors.white.withValues(alpha: .72),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    IconBox(
                      icon: mission.icon,
                      color: Colors.white,
                      bg: Colors.white.withValues(alpha: .14),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      mission.title(widget.lang),
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
                      mission.desc(widget.lang),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .72),
                        fontSize: 15,
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Text(
                          _status == 'COMPLETED'
                              ? (en ? 'Completed' : '완료')
                              : _status == 'IN_PROGRESS'
                                  ? (en ? 'In Progress' : '진행 중')
                                  : (en ? 'Available' : '수락 가능'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _status == 'COMPLETED'
                              ? '100%'
                              : _status == 'IN_PROGRESS'
                                  ? (en ? 'In progress' : '진행중')
                                  : '0%',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .72),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: _status == 'COMPLETED'
                            ? 1.0
                            : _status == 'IN_PROGRESS'
                                ? 0.5
                                : 0.0,
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
                lang: widget.lang,
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
              if (_status == 'COMPLETED')
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: C.blueSoft,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified_rounded, color: C.blue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        en ? 'Mission completed' : '미션 완료됨',
                        style: const TextStyle(
                          color: C.blue,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              else if (_status == 'AVAILABLE')
                PrimaryButton(
                  label: _busy
                      ? (en ? 'Processing...' : '처리 중...')
                      : (en ? 'Accept mission' : '미션 수락하기'),
                  icon: Icons.flag_rounded,
                  color: C.blue,
                  onTap: _acceptMission,
                )
              else ...[
                // IN_PROGRESS
                if (isVerify)
                  PrimaryButton(
                    label: en ? 'Start verification' : '인증 시작하기',
                    icon: Icons.camera_alt_rounded,
                    color: C.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyScreen(
                          mission: mission,
                          lang: widget.lang,
                        ),
                      ),
                    ),
                  )
                else
                  PrimaryButton(
                    label: _busy
                        ? (en ? 'Processing...' : '처리 중...')
                        : (en ? 'Mark guide as read' : '가이드 읽음 처리'),
                    icon: Icons.check_rounded,
                    color: C.blue,
                    onTap: _completeGuide,
                  ),
              ],
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
      color = C.blue;
      bg = C.blueSoft;
      phrase = en ? 'Please go to this address.' : '이 주소로 가주세요.';
      desc = en ? 'Show this to the driver if communication is difficult.' : '말이 잘 통하지 않을 때 기사님께 보여주면 좋습니다.';
    } else if (title.contains('배달') || lower.contains('delivery')) {
      icon = Icons.delivery_dining_rounded;
      color = C.blue;
      bg = C.blueSoft;
      phrase = en ? 'Please leave it at the door.' : '문 앞에 놓아주세요.';
      desc = en ? 'Useful as a delivery request note.' : '배달 요청사항에 바로 사용할 수 있습니다.';
    } else if (title.contains('병원') || lower.contains('clinic') || lower.contains('pharmacy')) {
      icon = Icons.local_hospital_rounded;
      color = C.blue;
      bg = C.blueSoft;
      phrase = en ? 'I have a fever.' : '열이 있어요.';
      desc = en ? 'Use this at a clinic or pharmacy counter.' : '병원 접수나 약국에서 사용할 수 있습니다.';
    } else if (title.contains('긴급') || lower.contains('emergency')) {
      icon = Icons.contact_phone_rounded;
      color = C.blue;
      bg = C.blueSoft;
      phrase = en ? 'Please call 119.' : '119에 전화해주세요.';
      desc = en ? 'Keep this ready for urgent situations.' : '긴급 상황에서 바로 보여줄 수 있도록 준비하세요.';
    } else if (title.contains('키오스크') || lower.contains('kiosk')) {
      icon = Icons.restaurant_rounded;
      color = C.blue;
      bg = C.blueSoft;
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
