part of '../../../../main.dart';

class CommunityPulseCard extends StatelessWidget {
  const CommunityPulseCard({
    super.key,
    required this.lang,
    required this.postCount,
    required this.solvedCount,
  });

  final AppLang lang;
  final int postCount;
  final int solvedCount;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: C.navy,
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
                en ? '$solvedCount solved' : '$solvedCount건 해결',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .72),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            en ? 'Ask when Korean systems are confusing.' : '한국 생활 절차가 헷갈릴 때 바로 물어보세요',
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
                ? 'Q&A focuses on real problems: ARC visits, T-money, delivery addresses, clinics, banking, and waste sorting.'
                : '외국인등록, T머니, 배달 주소, 병원, 은행, 분리수거처럼 실제 막히는 문제 중심으로 답변합니다.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .68),
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
              Expanded(child: CommunityPulseStat(label: en ? 'Posts' : '게시글', value: '$postCount')),
              const SizedBox(width: 8),
              Expanded(child: CommunityPulseStat(label: en ? 'Solved' : '해결', value: '$solvedCount')),
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
        color: Colors.white.withValues(alpha: .10),
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
              color: Colors.white.withValues(alpha: .62),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
