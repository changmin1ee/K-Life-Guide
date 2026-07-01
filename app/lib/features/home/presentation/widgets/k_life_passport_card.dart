part of '../../../../main.dart';

class KLifePassportCard extends StatelessWidget {
  const KLifePassportCard({
    super.key,
    required this.lang,
    required this.onTap,
  });

  final AppLang lang;
  final VoidCallback onTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
              child: const LinearProgressIndicator(
                value: .58,
                minHeight: 10,
                color: C.blue,
                backgroundColor: C.blueSoft,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: PassportMiniStat(label: en ? 'Transport' : '교통', value: '70%')),
                const SizedBox(width: 8),
                Expanded(child: PassportMiniStat(label: en ? 'Food' : '음식', value: '45%')),
                const SizedBox(width: 8),
                Expanded(child: PassportMiniStat(label: en ? 'Admin' : '행정', value: '30%')),
              ],
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
