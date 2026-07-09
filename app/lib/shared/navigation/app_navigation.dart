part of '../../main.dart';

Future<void> openMission(
  BuildContext context,
  Mission mission,
  AppLang lang,
  ValueChanged<AppLang> onLangChanged,
) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MissionDetailScreen(
        mission: mission,
        lang: lang,
        onLangChanged: onLangChanged,
      ),
    ),
  );
}

void openPost(BuildContext context, String title, AppLang lang) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PostDetailScreen(title: title, lang: lang),
    ),
  );
}

Future<void> completeSheet(BuildContext context, Mission mission, AppLang lang) {
  final en = lang == AppLang.en;

  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: C.blueSoft,
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: C.blue,
              size: 34,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            en ? 'Mission complete!' : '미션 완료!',
            style: const TextStyle(
              color: C.black,
              fontSize: 27,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            en
                ? 'Reward +${mission.xp} XP · ${mission.point}P will be added.'
                : '보상 +${mission.xp} XP · ${mission.point}P가 지급됩니다.',
            style: const TextStyle(
              color: C.gray,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 22),
          PrimaryButton(
            label: en ? 'OK' : '확인',
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    ),
  );
}

void showLanguageSheet(
  BuildContext context,
  AppLang current,
  ValueChanged<AppLang> onChanged,
) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (_) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            current == AppLang.en ? 'Language' : '언어 선택',
            style: const TextStyle(
              color: C.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          MenuTile(
            icon: current == AppLang.ko
                ? Icons.check_rounded
                : Icons.language_rounded,
            title: '한국어',
            subtitle: current == AppLang.ko ? '현재 선택됨' : 'Korean',
            onTap: () {
              onChanged(AppLang.ko);
              Navigator.pop(context);
            },
          ),
          MenuTile(
            icon: current == AppLang.en
                ? Icons.check_rounded
                : Icons.language_rounded,
            title: 'English',
            subtitle: current == AppLang.en ? 'Selected' : '영어로 변경',
            onTap: () {
              onChanged(AppLang.en);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

void toast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
