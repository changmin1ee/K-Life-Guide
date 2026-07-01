part of '../../../../main.dart';

class SmallChip extends StatelessWidget {
  const SmallChip({
    super.key,
    required this.text,
    required this.color,
    required this.bg,
  });

  final String text;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
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

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final completed = isMissionCompleted(mission);
    final hasProgress = mission.progress > 0;
    final statusText = completed
        ? (en ? 'Completed' : '완료됨')
        : mission.status(lang);
    final actionText = completed
        ? (en ? 'View history' : '기록 보기')
        : hasProgress
            ? (en ? 'Continue' : '계속하기')
            : mission.type == MissionType.verify
                ? (en ? 'Start verification' : '인증 시작')
                : (en ? 'Read guide' : '가이드 보기');

    final accent = completed
        ? C.blue
        : mission.type == MissionType.verify
            ? C.blue
            : C.blue;

    final soft = completed
        ? C.blueSoft
        : mission.type == MissionType.verify
            ? C.blueSoft
            : C.blueSoft;

    final progressValue = completed ? 1.0 : mission.progress;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: TossCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBox(
                  icon: completed ? Icons.verified_rounded : mission.icon,
                  color: accent,
                  bg: soft,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          SmallChip(
                            text: mission.category(lang),
                            color: C.gray,
                            bg: C.inkSoft,
                          ),
                          SmallChip(
                            text: statusText,
                            color: accent,
                            bg: soft,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mission.title(lang),
                        style: const TextStyle(
                          color: C.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: C.gray,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 13),
            Text(
              mission.desc(lang),
              style: const TextStyle(
                color: C.gray,
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: progressValue,
                minHeight: 8,
                backgroundColor: C.inkSoft,
                valueColor: AlwaysStoppedAnimation<Color>(accent),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  completed ? Icons.check_circle_rounded : Icons.flag_rounded,
                  color: accent,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  completed
                      ? (en ? 'Reflected in your settlement history' : '정착 기록에 반영됨')
                      : '+${mission.xp} XP · +${mission.point}P',
                  style: TextStyle(
                    color: completed ? C.blue : C.gray,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: completed ? C.blueSoft : C.inkSoft,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    actionText,
                    style: TextStyle(
                      color: completed ? C.blue : C.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ],
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
