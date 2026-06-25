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
    AdminGuidePage(),
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
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment),
            label: '행정',
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
      subtitle: '외국인의 한국 정착을 돕는 미션형 생활 가이드',
      children: [
        FeatureSectionTitle(title: 'MVP 핵심 구조'),
        InfoCard(
          icon: Icons.login,
          title: '사용자 인증',
          content: '회원가입, 로그인, 로그아웃과 JWT 기반 보호 API 접근을 공통 기반으로 둡니다.',
        ),
        InfoCard(
          icon: Icons.flag,
          title: '미션 시스템',
          content: '교통, 음식, 행정, 생활 미션을 수행하고 XP, 레벨, 뱃지를 얻는 앱의 핵심 기능입니다.',
        ),
        InfoCard(
          icon: Icons.camera_alt,
          title: '인증 / 검증',
          content: '앱 내 카메라 촬영, GPS, 촬영 시각, Gemini 이미지 검증을 조합하여 인증합니다.',
        ),
        InfoCard(
          icon: Icons.language,
          title: '다국어 범위',
          content: '외국인 대상 서비스이지만 MVP에서는 한글과 영어 중심으로 범위를 제한합니다.',
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
        FeatureSectionTitle(title: '미션 기능'),
        InfoCard(
          icon: Icons.list_alt,
          title: '미션 목록 / 상세 조회',
          content: '교통, 음식, 행정, 생활 카테고리별 목록과 보상 XP, 설명, 공략, 인증 방식을 보여줍니다.',
        ),
        InfoCard(
          icon: Icons.play_circle_outline,
          title: '미션 수락 / 포기',
          content: '사용자가 미션을 수락하거나 포기할 수 있도록 상태를 관리합니다.',
        ),
        InfoCard(
          icon: Icons.sync_alt,
          title: '상태 전이',
          content: '수락 → 수행 → 인증 제출 → 검증 → 승인/반려 → 재제출 흐름으로 구성합니다.',
        ),
        FeatureSectionTitle(title: '인증 방식'),
        InfoCard(
          icon: Icons.verified,
          title: '검증형 미션',
          content: '교통, 생활, 음식 미션은 앱 내 카메라 촬영, GPS, Gemini 이미지 검증을 사용합니다.',
        ),
        InfoCard(
          icon: Icons.menu_book,
          title: '가이드형 미션',
          content: '행정 미션은 시스템 검증 대신 단계별 가이드 열람과 자가 완료 체크를 사용합니다.',
        ),
        InfoCard(
          icon: Icons.admin_panel_settings,
          title: '관리자 검토 폴백',
          content: 'Gemini confidence가 낮은 인증 건은 관리자 검토 큐로 보내 승인 또는 반려 처리합니다.',
        ),
        FeatureSectionTitle(title: '보상'),
        InfoCard(
          icon: Icons.stars,
          title: 'XP / 레벨 / 뱃지',
          content: '검증 통과 시 XP 지급, 레벨업 처리, 뱃지 발급을 하나의 흐름으로 처리합니다.',
        ),
      ],
    );
  }
}

class AdminGuidePage extends StatelessWidget {
  const AdminGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPageLayout(
      title: '행정 가이드',
      subtitle: '시스템 검증이 어려운 행정 절차를 단계별 콘텐츠로 안내합니다.',
      children: [
        InfoCard(
          icon: Icons.badge_outlined,
          title: '외국인등록증',
          content: '방문 장소, 준비 서류, 처리 순서, 관련 링크를 안내합니다.',
        ),
        InfoCard(
          icon: Icons.account_balance,
          title: '통장 개설',
          content: '은행 방문 전 준비물, 계좌 개설 절차, 주의사항을 정리합니다.',
        ),
        InfoCard(
          icon: Icons.phone_android,
          title: '휴대폰 개통',
          content: '통신사 방문, 유심 개통, 본인인증 관련 절차를 안내합니다.',
        ),
        InfoCard(
          icon: Icons.check_circle_outline,
          title: '자가 완료 체크',
          content: '행정 미션은 사용자가 가이드를 확인한 뒤 자가 완료 체크를 하는 방식으로 구성합니다.',
        ),
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
        InfoCard(
          icon: Icons.article_outlined,
          title: '자유게시판',
          content: '생활 후기, 정보 공유, 지역 이야기를 작성하고 조회합니다.',
        ),
        InfoCard(
          icon: Icons.question_answer_outlined,
          title: 'Q&A 게시판',
          content: '한국 생활 중 궁금한 점을 질문하고 답변을 받을 수 있습니다.',
        ),
        InfoCard(
          icon: Icons.comment_outlined,
          title: '댓글 CRUD',
          content: '게시글에 댓글을 작성, 조회, 수정, 삭제할 수 있도록 구성합니다.',
        ),
        InfoCard(
          icon: Icons.thumb_up_alt_outlined,
          title: '추천 / 신고',
          content: '좋아요와 신고 기능을 통해 커뮤니티 정보 품질을 관리합니다.',
        ),
        InfoCard(
          icon: Icons.military_tech_outlined,
          title: '레벨 / 뱃지 표시',
          content: '게시글과 댓글에 작성자의 레벨과 대표 뱃지를 표시하여 미션 시스템과 연결합니다.',
        ),
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
      subtitle: '사용자의 성장 정보와 활동 기록을 보여줍니다.',
      children: [
        InfoCard(
          icon: Icons.person,
          title: '내 프로필',
          content: '이름, 사진, 레벨, 경험치 바, 정착일 카운팅을 표시합니다.',
        ),
        InfoCard(
          icon: Icons.workspace_premium_outlined,
          title: '뱃지 컬렉션',
          content: '완료한 미션에 따라 획득한 뱃지를 모아 보여줍니다.',
        ),
        InfoCard(
          icon: Icons.task_alt,
          title: '내가 깬 미션',
          content: '사용자가 완료한 미션 목록을 조회합니다.',
        ),
        InfoCard(
          icon: Icons.edit_note,
          title: '내가 쓴 글',
          content: '커뮤니티에 작성한 게시글과 댓글을 확인합니다.',
        ),
        InfoCard(
          icon: Icons.people_outline,
          title: '친구 목록',
          content: '우선순위는 낮지만, 추후 친구 목록 조회 기능을 추가할 수 있습니다.',
        ),
        InfoCard(
          icon: Icons.notifications_none,
          title: '알림',
          content: '미션 승인/반려, 댓글 알림은 선택 기능으로 두고 시간이 남을 때 FCM으로 구현합니다.',
        ),
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

class FeatureSectionTitle extends StatelessWidget {
  const FeatureSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
