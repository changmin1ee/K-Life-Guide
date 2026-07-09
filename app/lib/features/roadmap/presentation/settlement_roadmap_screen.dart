part of '../../../main.dart';

class SettlementRoadmapScreen extends StatefulWidget {
  const SettlementRoadmapScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<SettlementRoadmapScreen> createState() =>
      _SettlementRoadmapScreenState();
}

class _SettlementRoadmapScreenState extends State<SettlementRoadmapScreen> {
  bool get en => widget.lang == AppLang.en;

  List<Map<String, dynamic>> _roadmapItems = [];
  bool _loadingRoadmap = true;

  @override
  void initState() {
    super.initState();
    _loadRoadmap();
  }

  Future<void> _loadRoadmap() async {
    try {
      final res = await ApiClient.dio.get('/api/roadmap');
      if (res.data['isSuccess'] == true) {
        final data = res.data['result'];
        setState(() {
          _roadmapItems =
              List<Map<String, dynamic>>.from(data['items'] ?? []);
          _loadingRoadmap = false;
        });
        return;
      }
    } catch (_) {}
    setState(() => _loadingRoadmap = false);
  }

  Future<void> _toggleItem(int itemId) async {
    try {
      await ApiClient.dio.post('/api/roadmap/$itemId/toggle');
      await _loadRoadmap(); // 토글 후 새로고침
    } catch (_) {}
  }

  IconData _itemIcon(String? iconKey) {
    return switch (iconKey) {
      'sim'       => Icons.sim_card_rounded,
      'transport' => Icons.credit_card_rounded,
      'location'  => Icons.location_on_rounded,
      'food'      => Icons.restaurant_rounded,
      'admin'     => Icons.badge_rounded,
      'safety'    => Icons.contact_phone_rounded,
      _           => Icons.check_circle_outline_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final completed =
        _roadmapItems.where((item) => item['done'] == true).length;
    final total = _roadmapItems.length;
    final progress = total > 0 ? completed / total : 0.0;

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
                child: _loadingRoadmap
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      )
                    : Column(
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
                            '$completed/$total',
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
              Header(
                title: en ? 'Recommended order' : '추천 진행 순서',
                action: '${(progress * 100).round()}%',
              ),
              if (_loadingRoadmap)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_roadmapItems.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      en ? 'No roadmap items yet.' : '로드맵 항목이 없어요.',
                      style: const TextStyle(
                          color: C.gray, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              else
                ...List.generate(
                  _roadmapItems.length,
                  (i) {
                    final item = _roadmapItems[i];
                    final isDone = item['done'] == true;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: item['id'] != null
                            ? () => _toggleItem((item['id'] as int?) ?? 0)
                            : null,
                        borderRadius: BorderRadius.circular(28),
                        child: TossCard(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              IconBox(
                                icon: _itemIcon(item['iconKey'] as String?),
                                color: C.blue,
                                bg: C.blueSoft,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      en
                                          ? (item['enTitle'] ?? '')
                                          : (item['koTitle'] ?? ''),
                                      style: const TextStyle(
                                        color: C.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      en
                                          ? (item['enDesc'] ?? '')
                                          : (item['koDesc'] ?? ''),
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
                                isDone
                                    ? Icons.check_circle_rounded
                                    : Icons.radio_button_unchecked_rounded,
                                color: isDone ? C.blue : C.gray,
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
                label: en ? 'Open missions and continue' : '미션에서 이어서 진행하기',
                icon: Icons.flag_rounded,
                color: C.blue,
                onTap: () => toast(
                  context,
                  en ? 'Use the mission tab to continue.' : '미션 탭에서 이어서 진행하세요.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
