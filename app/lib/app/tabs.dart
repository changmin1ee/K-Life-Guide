part of '../main.dart';

class Tabs extends StatefulWidget {
  const Tabs({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final en = widget.lang == AppLang.en;

    final pages = [
      HomeScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
      MissionScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
      CommunityScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
      ProfileScreen(lang: widget.lang, onLangChanged: widget.onLangChanged),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home_rounded),
            label: en ? 'Home' : '홈',
          ),
          NavigationDestination(
            icon: const Icon(Icons.flag_outlined),
            selectedIcon: const Icon(Icons.flag_rounded),
            label: en ? 'Missions' : '미션',
          ),
          NavigationDestination(
            icon: const Icon(Icons.forum_outlined),
            selectedIcon: const Icon(Icons.forum_rounded),
            label: en ? 'Community' : '커뮤니티',
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person_rounded),
            label: en ? 'Profile' : '프로필',
          ),
        ],
      ),
    );
  }
}
