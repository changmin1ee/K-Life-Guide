part of '../../../main.dart';

class CompletedMissionsScreen extends StatelessWidget {
  const CompletedMissionsScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserProgressState>(
      valueListenable: userProgress,
      builder: (context, progress, _) {
        final completed = progress.completedMissionTitles.toList();

        return Scaffold(
          backgroundColor: C.bg,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(18),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: C.black,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          en ? 'Completed missions' : '완료한 미션',
                          style: const TextStyle(
                            color: C.black,
                            fontSize: 28,
                            letterSpacing: -1,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  TossCard(
                    child: Row(
                      children: [
                        IconBox(
                          icon: Icons.verified_rounded,
                          color: C.blue,
                          bg: C.blueSoft,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            en
                                ? '${progress.completedCount} real-life tasks completed'
                                : '실생활 미션 ${progress.completedCount}개 완료',
                            style: const TextStyle(
                              color: C.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Header(
                    title: en ? 'History' : '완료 기록',
                    action: '${progress.completedCount}',
                  ),
                  ...completed.map(
                    (title) => DoneTile(
                      title: title,
                      lang: lang,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
