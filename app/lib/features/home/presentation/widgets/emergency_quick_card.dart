part of '../../../../main.dart';

class EmergencyQuickCard extends StatelessWidget {
  const EmergencyQuickCard({
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: C.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBox(
                icon: Icons.sos_rounded,
                color: C.blue,
                bg: C.blueSoft,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Emergency help card' : '긴급 상황 도움말',
                      style: const TextStyle(
                        color: C.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      en
                          ? 'Copy a number with a Korean sentence you can show immediately.'
                          : '전화번호와 도움 요청 문장을 함께 복사해서 보여줄 수 있어요.',
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
            ],
          ),
          const SizedBox(height: 16),
          EmergencyContactRow(
            icon: Icons.local_hospital_rounded,
            title: en ? '119 Emergency' : '119 응급·화재·구조',
            subtitle: en ? 'Ambulance, fire, rescue' : '구급차, 화재, 구조 요청',
            number: '119',
            phrase: en ? 'Please call 119.' : '119에 전화해주세요.',
            lang: lang,
          ),
          const SizedBox(height: 8),
          EmergencyContactRow(
            icon: Icons.local_police_rounded,
            title: en ? '112 Police' : '112 경찰 신고',
            subtitle: en ? 'Crime, danger, urgent police help' : '범죄, 위험 상황, 경찰 도움 요청',
            number: '112',
            phrase: en ? 'Please call the police.' : '경찰을 불러주세요.',
            lang: lang,
          ),
          const SizedBox(height: 8),
          EmergencyContactRow(
            icon: Icons.support_agent_rounded,
            title: en ? '1330 Travel helpline' : '1330 관광·통역 안내',
            subtitle: en ? 'Korea travel and interpretation help' : '관광 안내와 통역 도움',
            number: '1330',
            phrase: en ? 'I do not speak Korean well.' : '한국어를 잘 못해요.',
            lang: lang,
          ),
        ],
      ),
    );
  }
}

class EmergencyContactRow extends StatelessWidget {
  const EmergencyContactRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.number,
    required this.phrase,
    required this.lang,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String number;
  final String phrase;
  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: C.blueSoft,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: C.blue, size: 21),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: C.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$subtitle · $phrase',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: C.gray,
                    fontSize: 12,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: '$number\n$phrase\nK-Life Guide emergency help'));
              if (context.mounted) {
                toast(
                  context,
                  en ? '$number copied with phrase.' : '$number 번호와 문장을 복사했습니다.',
                );
              }
            },
            borderRadius: BorderRadius.circular(14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
              decoration: BoxDecoration(
                color: C.blueSoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                en ? 'Copy help' : '도움 복사',
                style: const TextStyle(
                  color: C.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
