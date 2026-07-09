part of '../main.dart';

class KLifeGuideApp extends StatefulWidget {
  const KLifeGuideApp({super.key});

  @override
  State<KLifeGuideApp> createState() => _KLifeGuideAppState();
}

class _KLifeGuideAppState extends State<KLifeGuideApp> {
  AppLang lang = AppLang.ko;
  bool loggedIn = false;
  bool _checking = true; // 초기 토큰 확인 중

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    if (isLoggedIn) {
      await loadUserProgress();
    }
    setState(() {
      loggedIn = isLoggedIn;
      _checking = false;
    });
  }

  void changeLang(AppLang value) => setState(() => lang = value);

  Future<void> _handleLogin() async {
    final success = await AuthService.signInWithGoogle();
    if (success && mounted) {
      await loadUserProgress();
      setState(() => loggedIn = true);
    }
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
      home: _checking
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : loggedIn
              ? Tabs(lang: lang, onLangChanged: changeLang)
              : LoginPage(
                  lang: lang,
                  onLangChanged: changeLang,
                  onLogin: _handleLogin,
                ),
    );
  }
}
