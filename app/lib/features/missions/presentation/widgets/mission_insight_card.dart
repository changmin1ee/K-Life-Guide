part of '../../../../main.dart';

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
                  color: Colors.white.withValues(alpha: .72),
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
              color: Colors.white.withValues(alpha: .68),
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
