part of '../../../main.dart';

class BadgeCollectionScreen extends StatelessWidget {
  const BadgeCollectionScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final badges = [
      [
        Icons.train_rounded,
        en ? 'Transit starter' : '교통 적응자',
        en ? 'Completed first transport mission' : '교통 미션 첫 완료',
      ],
      [
        Icons.restaurant_rounded,
        en ? 'Kiosk challenger' : '키오스크 도전자',
        en ? 'Tried a kiosk order' : '키오스크 주문 완료',
      ],
      [
        Icons.badge_rounded,
        en ? 'Admin learner' : '행정 준비생',
        en ? 'Read an admin guide' : '행정 가이드 확인',
      ],
      [
        Icons.language_rounded,
        en ? 'Local explorer' : '생활 탐험가',
        en ? 'Used local life tips' : '생활 정보 활용',
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
                en ? 'Badges' : '뱃지 컬렉션',
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
                en ? 'Badges earned from settlement missions.' : '정착 미션을 통해 얻은 뱃지를 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Header(title: en ? 'Earned badges' : '획득한 뱃지', action: '4'),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: badges.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: .92,
                ),
                itemBuilder: (context, index) {
                  final badge = badges[index];

                  return TossCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconBox(
                          icon: badge[0] as IconData,
                          color: C.blue,
                          bg: C.blueSoft,
                        ),
                        const Spacer(),
                        Text(
                          badge[1] as String,
                          style: const TextStyle(
                            color: C.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          badge[2] as String,
                          style: const TextStyle(
                            color: C.gray,
                            fontSize: 12,
                            height: 1.35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
