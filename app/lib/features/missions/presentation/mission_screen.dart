part of '../../../main.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  MissionFilter filter = MissionFilter.all;

  @override
  Widget build(BuildContext context) {
    final en = widget.lang == AppLang.en;

    final filtered = missions.where((m) {
      if (filter == MissionFilter.all) return true;
      if (filter == MissionFilter.verify) return m.type == MissionType.verify;
      return m.type == MissionType.guide;
    }).toList();

    return PageShell(
      lang: widget.lang,
      onLangChanged: widget.onLangChanged,
      title: en ? 'Missions' : '미션',
      subtitle: en ? 'Verification missions and admin guides.' : '검증 미션과 행정 가이드를 한 곳에서 관리해요.',
      children: [
        MissionInsightCard(lang: widget.lang),
        const SizedBox(height: 14),
        FilterBar(
          labels: en ? const ['All', 'Verify', 'Guides'] : const ['전체', '검증', '가이드'],
          selected: filter.index,
          onTap: (i) => setState(() => filter = MissionFilter.values[i]),
        ),
        Header(
          title: en ? 'Recommended' : '추천 미션',
          action: '${filtered.length}',
        ),
        ...filtered.map(
          (m) => MissionCard(
            mission: m,
            lang: widget.lang,
            onTap: () => openMission(
              context,
              m,
              widget.lang,
              widget.onLangChanged,
            ),
          ),
        ),
      ],
    );
  }
}
