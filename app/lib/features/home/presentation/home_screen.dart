part of '../../../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final active = missions.where((m) => m.progress > 0).toList();

    return ValueListenableBuilder<UserProgressState>(
      valueListenable: userProgress,
      builder: (context, progress, _) {
        final completedTitles = progress.completedMissionTitles.toList();

        return PageShell(
          lang: lang,
          onLangChanged: onLangChanged,
          title: en ? 'Home' : '홈',
          subtitle: en ? 'One more step toward life in Korea.' : '오늘 필요한 한국 생활 업무를 하나씩 해결해요.',
          children: [
            ProfileCard(lang: lang),
            const SizedBox(height: 14),
            TodayBriefCard(
              lang: lang,
              onPrimaryTap: () => openMission(context, missions.first, lang, onLangChanged),
              onSecondaryTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TodayChecklistScreen(lang: lang),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ServiceToolkitCard(
              lang: lang,
              onPhraseTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SurvivalPhraseScreen(lang: lang)),
              ),
              onDeliveryTap: () => openMission(context, missions[5], lang, onLangChanged),
              onEmergencyTap: () => openMission(context, missions[9], lang, onLangChanged),
            ),
            const SizedBox(height: 14),
            EmergencyQuickCard(lang: lang),
            const SizedBox(height: 14),
            KLifePassportCard(
              lang: lang,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PassportScreen(lang: lang)),
              ),
            ),
            const SizedBox(height: 14),
            SettlementRoadmapCard(
              lang: lang,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettlementRoadmapScreen(lang: lang)),
              ),
            ),
            Header(
              title: en ? 'In progress' : '진행 중인 미션',
              action: '${active.length}',
            ),
            ...active.map(
              (m) => MissionCard(
                mission: m,
                lang: lang,
                onTap: () => openMission(context, m, lang, onLangChanged),
              ),
            ),
            Header(
              title: en ? 'Completed' : '완료한 미션',
              action: '${progress.completedCount}',
            ),
            ...completedTitles.take(5).map(
              (title) => DoneTile(
                title: title,
                lang: lang,
              ),
            ),
          ],
        );
      },
    );
  }
}
