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
