import 'package:flutter/material.dart';

void main() {
  runApp(const KLifeGuideApp());
}

class KLifeGuideApp extends StatelessWidget {
  const KLifeGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Life Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainTabPage(),
    );
  }
}

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    MissionPage(),
    CommunityPage(),
    ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag_outlined),
            selectedIcon: Icon(Icons.flag),
            label: '미션',
          ),
          NavigationDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum),
            label: '커뮤니티',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageLayout(
      title: 'K-Life Guide',
      subtitle: '한국 생활을 미션처럼 익히는 정착 가이드',
      children: [
        InfoCard(
          title: '오늘의 목표',
          content: '기능이 확정되기 전까지는 전체 앱 구조와 화면 흐름을 먼저 잡습니다.',
        ),
        InfoCard(
          title: '추천 미션 영역',
          content: '교통, 음식, 행정, 생활 미션이 이곳에 표시될 예정입니다.',
        ),
        InfoCard(
          title: '커뮤니티 미리보기 영역',
          content: '자유게시판과 Q&A 게시판의 최신 글이 이곳에 표시될 예정입니다.',
        ),
      ],
    );
  }
}

class MissionPage extends StatelessWidget {
  const MissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageLayout(
      title: '미션',
      subtitle: '정착에 필요한 행동을 단계별 미션으로 제공합니다.',
      children: [
        InfoCard(title: '교통', content: 'T머니, 지하철, 버스, 택시 관련 미션'),
        InfoCard(title: '음식', content: '키오스크, 배달앱, 카페 주문 관련 미션'),
        InfoCard(title: '행정', content: '외국인등록, 은행, 통신, 병원 관련 미션'),
        InfoCard(title: '생활', content: '분리수거, 공공시설, 생활 규칙 관련 미션'),
      ],
    );
  }
}

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageLayout(
      title: '커뮤니티',
      subtitle: '외국인 사용자가 서로 질문하고 정보를 공유하는 공간입니다.',
      children: [
        InfoCard(title: '자유게시판', content: '생활 후기, 정보 공유, 지역 이야기'),
        InfoCard(title: 'Q&A 게시판', content: '한국 생활 중 궁금한 점을 질문하는 공간'),
        InfoCard(title: '신고 / 추천 기능', content: '게시글 품질 관리를 위한 기능 예정'),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageLayout(
      title: '프로필',
      subtitle: '사용자의 레벨, 경험치, 뱃지, 활동 기록을 보여줍니다.',
      children: [
        InfoCard(title: '레벨 / 경험치', content: '미션 수행과 커뮤니티 활동에 따라 성장'),
        InfoCard(title: '뱃지 컬렉션', content: '완료한 미션에 따라 뱃지 획득 예정'),
        InfoCard(title: '내 활동', content: '내가 완료한 미션과 작성한 글 확인'),
      ],
    );
  }
}

class AppPageLayout extends StatelessWidget {
  const AppPageLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
