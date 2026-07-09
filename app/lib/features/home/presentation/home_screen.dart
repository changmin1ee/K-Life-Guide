part of '../../../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool get en => widget.lang == AppLang.en;

  @override
  void initState() {
    super.initState();
    _loadHomeData();
  }

  Future<void> _loadHomeData() async {
    // 미션 목록 로드 (missionListNotifier가 비어있을 때만)
    if (missionListNotifier.value.isEmpty) {
      try {
        final res = await ApiClient.dio.get('/api/missions');
        if (res.data['isSuccess'] == true) {
          missionListNotifier.value = (res.data['result'] as List)
              .map((d) => missionFromApi(d as Map<String, dynamic>))
              .toList();
        }
      } catch (_) {}
    }
    // 유저 정보 로드
    if (userProgress.value.points == 0 && userProgress.value.xp == 0) {
      await loadUserProgress();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final active = missions.where((m) => m.progress > 0).toList();

    return ValueListenableBuilder<UserProgressState>(
      valueListenable: userProgress,
      builder: (context, progress, _) {
        final completedTitles = progress.completedMissionTitles.toList();

        return PageShell(
          lang: widget.lang,
          onLangChanged: widget.onLangChanged,
          title: en ? 'Home' : '홈',
          subtitle: en ? 'One more step toward life in Korea.' : '오늘 필요한 한국 생활 업무를 하나씩 해결해요.',
          children: [
            ProfileCard(lang: widget.lang),
            const SizedBox(height: 14),
            TodayBriefCard(
              lang: widget.lang,
              onPrimaryTap: missions.isEmpty
                  ? () {}
                  : () async {
                      await openMission(context, missions.first, widget.lang, widget.onLangChanged);
                      if (mounted) _loadHomeData();
                    },
              onSecondaryTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodayChecklistScreen(lang: widget.lang),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ServiceToolkitCard(
              lang: widget.lang,
              onPhraseTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SurvivalPhraseScreen(lang: widget.lang)),
              ),
              onDeliveryTap: missions.length > 5
                  ? () async {
                      await openMission(context, missions[5], widget.lang, widget.onLangChanged);
                      if (mounted) _loadHomeData();
                    }
                  : () {},
              onEmergencyTap: missions.length > 9
                  ? () async {
                      await openMission(context, missions[9], widget.lang, widget.onLangChanged);
                      if (mounted) _loadHomeData();
                    }
                  : () {},
            ),
            const SizedBox(height: 14),
            EmergencyQuickCard(lang: widget.lang),
            const SizedBox(height: 14),
            KLifePassportCard(
              lang: widget.lang,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PassportScreen(lang: widget.lang)),
              ),
            ),
            const SizedBox(height: 14),
            SettlementRoadmapCard(
              lang: widget.lang,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettlementRoadmapScreen(lang: widget.lang)),
              ),
            ),
            Header(
              title: en ? 'In progress' : '진행 중인 미션',
              action: '${active.length}',
            ),
            ...active.map(
              (m) => MissionCard(
                mission: m,
                lang: widget.lang,
                onTap: () async {
                  await openMission(context, m, widget.lang, widget.onLangChanged);
                  if (mounted) _loadHomeData();
                },
              ),
            ),
            Header(
              title: en ? 'Completed' : '완료한 미션',
              action: '${progress.completedCount}',
            ),
            ...completedTitles.take(5).map(
              (title) => DoneTile(
                title: title,
                lang: widget.lang,
              ),
            ),
          ],
        );
      },
    );
  }
}
