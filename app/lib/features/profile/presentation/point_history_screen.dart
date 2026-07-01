part of '../../../main.dart';

class PointHistoryScreen extends StatelessWidget {
  const PointHistoryScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final items = [
      [
        en ? 'T-money top-up mission' : 'T머니 카드 충전하기',
        '+300P',
        en ? 'Verification reward' : '인증 보상',
      ],
      [
        en ? 'Kiosk order mission' : '키오스크로 주문하기',
        '+400P',
        en ? 'Verification reward' : '인증 보상',
      ],
      [
        en ? 'ARC guide completed' : '외국인등록증 가이드 확인',
        '+100P',
        en ? 'Guide reward' : '가이드 보상',
      ],
      [
        en ? 'Daily check-in' : '오늘의 출석',
        '+50P',
        en ? 'Daily bonus' : '일일 보너스',
      ],
    ];

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
                en ? 'Point history' : '포인트 내역',
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
                en ? 'See where your points came from.' : '포인트를 어디서 얻었는지 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              TossCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Current points' : '현재 포인트',
                      style: const TextStyle(
                        color: C.gray,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '3,200P',
                      style: TextStyle(
                        color: C.black,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.2,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: const LinearProgressIndicator(
                        value: .72,
                        minHeight: 10,
                        color: C.blue,
                        backgroundColor: C.blueSoft,
                      ),
                    ),
                  ],
                ),
              ),
              Header(title: en ? 'Recent activity' : '최근 적립 내역'),
              ...items.map(
                (item) => ListRow(
                  icon: Icons.add_rounded,
                  iconColor: C.blue,
                  iconBg: C.blueSoft,
                  title: item[0],
                  subtitle: '${item[2]} · ${item[1]}',
                  onTap: () => toast(context, item[1]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
