part of '../../../../main.dart';

class KLifePassportCard extends StatefulWidget {
  const KLifePassportCard({
    super.key,
    required this.lang,
    required this.onTap,
  });

  final AppLang lang;
  final VoidCallback onTap;

  @override
  State<KLifePassportCard> createState() => _KLifePassportCardState();
}

class _KLifePassportCardState extends State<KLifePassportCard> {
  bool get en => widget.lang == AppLang.en;

  double _overall = 0.0;
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadPassport();
  }

  Future<void> _loadPassport() async {
    try {
      final res = await ApiClient.dio.get('/api/members/me/passport');
      if (res.data['isSuccess'] == true) {
        final cats = List<Map<String, dynamic>>.from(
            res.data['result']['categoryAdaptations'] ?? []);
        final total = cats.isEmpty
            ? 0.0
            : cats
                    .map((c) => ((c['adaptationRate'] ?? 0.0) as num).toDouble())
                    .reduce((a, b) => a + b) /
                cats.length;
        if (mounted) {
          setState(() {
            _categories = cats;
            _overall = total;
          });
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    // 표시할 카테고리 최대 3개
    final displayCats = _categories.take(3).toList();

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: C.blueSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.map_rounded, color: C.blue, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        en ? 'K-Life Passport' : 'K-라이프 패스포트',
                        style: const TextStyle(
                          color: C.black,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        en ? 'Your settlement readiness map' : '한국 생활 적응도를 한눈에 보는 지도',
                        style: const TextStyle(
                          color: C.gray,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: C.gray),
              ],
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: _overall,
                minHeight: 10,
                color: C.blue,
                backgroundColor: C.blueSoft,
              ),
            ),
            const SizedBox(height: 12),
            if (displayCats.isEmpty)
              Row(
                children: [
                  Expanded(child: PassportMiniStat(label: en ? 'Transport' : '교통', value: '0%')),
                  const SizedBox(width: 8),
                  Expanded(child: PassportMiniStat(label: en ? 'Food' : '음식', value: '0%')),
                  const SizedBox(width: 8),
                  Expanded(child: PassportMiniStat(label: en ? 'Admin' : '행정', value: '0%')),
                ],
              )
            else
              Row(
                children: displayCats.asMap().entries.map((e) {
                  final cat = e.value;
                  final rate = ((cat['adaptationRate'] ?? 0.0) as num).toDouble();
                  final label = en
                      ? (cat['enCategory'] ?? '')
                      : (cat['koCategory'] ?? '');
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: e.key == 0 ? 0 : 8),
                      child: PassportMiniStat(
                        label: label,
                        value: '${(rate * 100).round()}%',
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class PassportMiniStat extends StatelessWidget {
  const PassportMiniStat({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: C.bg,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: C.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: C.gray,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
