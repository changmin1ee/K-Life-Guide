part of '../../../../main.dart';

class SurvivalPhraseCard extends StatelessWidget {
  const SurvivalPhraseCard({
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
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: C.blueSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.record_voice_over_rounded, color: C.blue, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    en ? 'Survival phrases' : '생활 필수 표현',
                    style: const TextStyle(
                      color: C.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    en
                        ? 'Show-ready Korean for taxi, delivery, clinics, banks, and emergencies'
                        : '말이 막힐 때 바로 보여줄 수 있는 한국어 문장',
                    style: const TextStyle(
                      color: C.gray,
                      fontSize: 13,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: C.gray),
          ],
        ),
      ),
    );
  }
}
