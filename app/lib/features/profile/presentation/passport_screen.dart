part of '../../../main.dart';

class PassportScreen extends StatefulWidget {
  const PassportScreen({super.key, required this.lang});
  final AppLang lang;
  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen> {
  bool get en => widget.lang == AppLang.en;
  List<Map<String, dynamic>> _categories = [];
  double _overall = 0.0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPassport();
  }

  Future<void> _loadPassport() async {
    try {
      final res = await ApiClient.dio.get('/api/members/me/passport');
      if (res.data['isSuccess'] == true) {
        final data = res.data['result'];
        final cats = List<Map<String, dynamic>>.from(
            data['categoryAdaptations'] ?? []);
        final total = cats.isEmpty
            ? 0.0
            : cats
                  .map((c) => ((c['adaptationRate'] ?? 0.0) as num).toDouble())
                  .reduce((a, b) => a + b) /
                cats.length;
        setState(() {
          _categories = cats;
          _overall = total;
          _loading = false;
        });
        return;
      }
    } catch (_) {}
    setState(() => _loading = false);
  }

  IconData _categoryIcon(String koCategory) {
    return switch (koCategory) {
      '교통' => Icons.train_rounded,
      '음식' => Icons.restaurant_rounded,
      '행정' => Icons.badge_rounded,
      '생활' => Icons.home_rounded,
      '안전' => Icons.contact_phone_rounded,
      _    => Icons.star_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
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
                en ? 'K-Life Passport' : 'K-라이프 패스포트',
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
                    ? 'A practical settlement map built from your missions.'
                    : '미션 기록을 바탕으로 한국 생활 적응도를 보여주는 실용 지표입니다.',
                style: const TextStyle(
                    color: C.gray, fontSize: 15, height: 1.4, fontWeight: FontWeight.w600),
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
                        color: Color(0x26000000),
                        blurRadius: 24,
                        offset: Offset(0, 12))
                  ],
                ),
                child: _loading
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
                            en ? 'Settlement readiness' : '정착 준비도',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: .72),
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${(_overall * 100).round()}%',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1.5),
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: _overall,
                              minHeight: 11,
                              color: Colors.white,
                              backgroundColor: const Color(0x33FFFFFF),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            en
                                ? 'You are ready for basic transport and daily tasks. Admin missions need more progress.'
                                : '기본 교통과 생활 미션은 안정적입니다. 행정 가이드 진행률을 더 높이면 좋습니다.',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: .7),
                                height: 1.45,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
              ),
              Header(title: en ? 'Readiness by area' : '분야별 적응도'),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_categories.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      en ? 'No data yet.' : '아직 데이터가 없어요.',
                      style: const TextStyle(
                          color: C.gray, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              else
                ..._categories.map(
                  (cat) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TossCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconBox(
                            icon: _categoryIcon(cat['koCategory'] ?? ''),
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
                                      ? (cat['enCategory'] ?? '')
                                      : (cat['koCategory'] ?? ''),
                                  style: const TextStyle(
                                      color: C.black,
                                      fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(999),
                                  child: LinearProgressIndicator(
                                    value: ((cat['adaptationRate'] ?? 0.0) as num)
                                        .toDouble(),
                                    minHeight: 8,
                                    color: C.blue,
                                    backgroundColor: C.blueSoft,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${(((cat['adaptationRate'] ?? 0.0) as num) * 100).round()}%',
                            style: const TextStyle(
                                color: C.black, fontWeight: FontWeight.w900),
                          ),
                        ],
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

class AdminInfoPanel extends StatelessWidget {
  const AdminInfoPanel({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AdminMiniCard(
                icon: Icons.schedule_rounded,
                title: en ? 'Time' : '소요 시간',
                value: en ? '1-2 weeks' : '1~2주',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AdminMiniCard(
                icon: Icons.payments_rounded,
                title: en ? 'Fee' : '수수료',
                value: en ? 'About 30,000 KRW' : '약 3만원',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TossCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.fact_check_rounded, color: C.blue),
                  const SizedBox(width: 8),
                  Text(
                    en ? 'Before you visit' : '방문 전 체크리스트',
                    style: const TextStyle(
                      color: C.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AdminCheckRow(text: en ? 'Passport and ID photo prepared' : '여권과 증명사진 준비'),
              AdminCheckRow(text: en ? 'Visit reservation completed' : '방문 예약 완료'),
              AdminCheckRow(text: en ? 'Address and contact number checked' : '주소와 연락처 확인'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: C.blueSoft,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: C.blue),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  en
                      ? 'Tip: Office requirements can differ by region. Check the latest notice before visiting.'
                      : '팁: 지역과 기관에 따라 요구 서류가 다를 수 있으므로 방문 전 최신 안내를 확인하세요.',
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
      ],
    );
  }
}

class AdminMiniCard extends StatelessWidget {
  const AdminMiniCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TossCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: C.blue),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: C.gray,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: C.black,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminCheckRow extends StatelessWidget {
  const AdminCheckRow({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: C.blueSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.check_rounded, color: C.blue, size: 16),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: C.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
