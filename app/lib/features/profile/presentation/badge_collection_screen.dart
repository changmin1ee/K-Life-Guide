part of '../../../main.dart';

class BadgeCollectionScreen extends StatefulWidget {
  const BadgeCollectionScreen({super.key, required this.lang});
  final AppLang lang;
  @override
  State<BadgeCollectionScreen> createState() => _BadgeCollectionScreenState();
}

class _BadgeCollectionScreenState extends State<BadgeCollectionScreen> {
  bool get en => widget.lang == AppLang.en;
  List<Map<String, dynamic>> _badges = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadBadges();
  }

  Future<void> _loadBadges() async {
    try {
      final res = await ApiClient.dio.get('/api/members/me/badges');
      if (res.data['isSuccess'] == true) {
        setState(() {
          _badges = List<Map<String, dynamic>>.from(res.data['result']);
          _loading = false;
        });
        return;
      }
    } catch (_) {}
    setState(() => _loading = false);
  }

  IconData _badgeIcon(String iconKey) {
    return switch (iconKey) {
      'transit'  => Icons.train_rounded,
      'food'     => Icons.restaurant_rounded,
      'admin'    => Icons.badge_rounded,
      'daily'    => Icons.home_rounded,
      'safety'   => Icons.contact_phone_rounded,
      'explorer' => Icons.explore_rounded,
      'pro'      => Icons.workspace_premium_rounded,
      _          => Icons.star_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final earnedBadges = _badges.where((b) => b['earned'] == true).toList();

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
              Header(
                title: en ? 'Earned badges' : '획득한 뱃지',
                action: '${earnedBadges.length}',
              ),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_badges.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      en ? 'No badges yet.' : '아직 획득한 뱃지가 없어요.',
                      style: const TextStyle(color: C.gray, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _badges.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: .92,
                  ),
                  itemBuilder: (context, index) {
                    final badge = _badges[index];
                    final earned = badge['earned'] == true;

                    return TossCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconBox(
                            icon: _badgeIcon(badge['iconKey'] ?? ''),
                            color: earned ? C.blue : C.gray,
                            bg: earned ? C.blueSoft : const Color(0xFFF3F4F6),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            en ? (badge['enName'] ?? '') : (badge['koName'] ?? ''),
                            style: TextStyle(
                              color: earned ? C.black : C.gray,
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            en ? (badge['enDesc'] ?? '') : (badge['koDesc'] ?? ''),
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
