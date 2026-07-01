part of '../../../../main.dart';

class ServiceToolkitCard extends StatelessWidget {
  const ServiceToolkitCard({
    super.key,
    required this.lang,
    required this.onPhraseTap,
    required this.onDeliveryTap,
    required this.onEmergencyTap,
  });

  final AppLang lang;
  final VoidCallback onPhraseTap;
  final VoidCallback onDeliveryTap;
  final VoidCallback onEmergencyTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return TossCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconBox(
                icon: Icons.home_repair_service_rounded,
                color: C.blue,
                bg: C.blueSoft,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Essential tools for today' : '지금 필요한 생활 도구',
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
                          ? 'Quick actions for situations foreigners actually face in Korea.'
                          : '택시, 배달, 병원처럼 자주 막히는 상황을 바로 처리해요.',
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
          ServiceToolRow(
            icon: Icons.translate_rounded,
            title: en ? 'Show Korean phrases' : '상황별 한국어 문장',
            subtitle: en ? 'Taxi, clinic, bank, delivery' : '기사님·약사·은행 직원에게 바로 보여주기',
            onTap: onPhraseTap,
          ),
          const SizedBox(height: 8),
          ServiceToolRow(
            icon: Icons.delivery_dining_rounded,
            title: en ? 'Prepare delivery order' : '배달 주문 전에 확인',
            subtitle: en ? 'Address, request note, payment' : '주소 입력, 요청사항, 결제까지',
            onTap: onDeliveryTap,
          ),
          const SizedBox(height: 8),
          ServiceToolRow(
            icon: Icons.contact_phone_rounded,
            title: en ? 'Save emergency contacts' : '긴급 연락처 저장하기',
            subtitle: en ? '119, 112, school or workplace' : '119·112·학교·회사 연락처',
            onTap: onEmergencyTap,
          ),
        ],
      ),
    );
  }
}

class ServiceToolRow extends StatelessWidget {
  const ServiceToolRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: C.chipBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: C.blue, size: 20),
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
                    subtitle,
                    style: const TextStyle(
                      color: C.gray,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: C.gray,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
