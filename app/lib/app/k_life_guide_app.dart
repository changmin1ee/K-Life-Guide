part of '../main.dart';

class KLifeGuideApp extends StatefulWidget {
  const KLifeGuideApp({super.key});

  @override
  State<KLifeGuideApp> createState() => _KLifeGuideAppState();
}

class _KLifeGuideAppState extends State<KLifeGuideApp> {
  AppLang lang = AppLang.ko;
  bool loggedIn = false;

  void changeLang(AppLang value) {
    setState(() => lang = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Life Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: C.blue,
          primary: C.blue,
          surface: Colors.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          height: 74,
          backgroundColor: Colors.white,
          indicatorColor: C.blueSoft,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
              color: selected ? C.blue : C.gray,
            );
          }),
        ),
      ),
      home: loggedIn
          ? Tabs(lang: lang, onLangChanged: changeLang)
          : LoginPage(
              lang: lang,
              onLangChanged: changeLang,
              onLogin: () => setState(() => loggedIn = true),
            ),
    );
  }
}
