part of '../../../../main.dart';

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
    return ValueListenableBuilder<UserProgressState>(
      valueListenable: userProgress,
      builder: (ctx, state, _) {
        return ValueListenableBuilder<String>(
          valueListenable: memberName,
          builder: (ctx2, name, _) {
            final xpInLevel = state.xp % 500;
            final xpProgress = xpInLevel / 500.0;

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
                            Text(
                              name,
                              style: const TextStyle(
                                color: C.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              en ? 'Living in Korea' : '한국 생활 중',
                              style: const TextStyle(
                                color: C.gray,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      LevelBadge(level: state.level),
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
                      Text(
                        '$xpInLevel / 500 XP',
                        style: const TextStyle(
                          color: C.gray,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: xpProgress,
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
                          value: '${state.points}P',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MetricBox(
                          label: en ? 'Completed' : '완료 미션',
                          value: '${state.completedMissionTitles.length}',
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
          },
        );
      },
    );
  }
}

class LevelBadge extends StatelessWidget {
  const LevelBadge({super.key, required this.level});

  final int level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: C.black,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Lv.$level',
        style: const TextStyle(
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
