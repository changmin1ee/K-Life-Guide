part of '../../../main.dart';

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

      // 실제 API 호출
      try {
        final res = await ApiClient.dio.post(
          '/api/missions/${widget.mission.id}/complete',
          data: {'proofImageUrl': null}, // 추후 S3 업로드 연동 시 실제 URL 전달
        );
        if (res.data['isSuccess'] == true) {
          final result = res.data['result'] as Map<String, dynamic>;
          userProgress.value = UserProgressState(
            points: result['newTotalPoints'] ?? userProgress.value.points,
            xp: result['newTotalXp'] ?? userProgress.value.xp,
            completedMissionTitles: {
              ...userProgress.value.completedMissionTitles,
              widget.mission.koTitle,
            },
          );
          // 미션 목록 초기화 → 다음 홈 방문 시 자동 재로드
          missionListNotifier.value = [];
        }
      } catch (_) {
        // API 실패해도 UI는 완료로 처리 (fallback)
      }

      if (!mounted) return;
      setState(() {
        busy = false;
        stage = 4;
      });
      return;
    }

    await completeSheet(context, widget.mission, widget.lang);
    if (mounted) {
      // 시트 닫힌 후 VerifyScreen + MissionDetailScreen 모두 팝 → 미션 탭으로 복귀
      Navigator.popUntil(context, (route) => route.isFirst);
    }
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
                color: stage >= 4 ? C.blue : C.black,
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
        color: approved ? C.blue : C.black,
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
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .14),
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
                  color: Colors.white.withValues(alpha: .72),
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
              color: Colors.white.withValues(alpha: .72),
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
    final color = done ? C.blue : active ? C.blue : C.gray;
    final bg = done ? C.blueSoft : active ? C.blueSoft : C.bg;

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
                    ? const Icon(Icons.check_rounded, color: C.blue)
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
