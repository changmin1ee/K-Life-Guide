part of '../../../main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.lang,
    required this.onLangChanged,
    required this.onLogin,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;
  final VoidCallback onLogin;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: LangButton(
                  lang: lang,
                  onTap: () => showLanguageSheet(context, lang, onLangChanged),
                ),
              ),
              const Spacer(),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: C.blue,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 22,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                en ? 'Settle in Korea\nwith simple missions' : '한국 생활을\n미션처럼 쉽게',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 36,
                  height: 1.15,
                  letterSpacing: -1.4,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                en
                    ? 'Transport, food, and admin guides\nfor foreigners living in Korea.'
                    : '교통카드, 배달, 병원, 행정 업무까지\n한국 생활에 필요한 일을 쉽게 따라 해보세요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 34),
              FeatureCard(
                icon: Icons.flag_rounded,
                title: en ? 'Mission-based guide' : '하나씩 따라 하는 정착 미션',
                subtitle: en ? 'Follow practical steps one by one' : '처음 해보는 일도 순서대로 따라 할 수 있어요',
              ),
              const SizedBox(height: 10),
              FeatureCard(
                icon: Icons.card_giftcard_rounded,
                title: en ? 'XP and point rewards' : '완료 기록과 포인트',
                subtitle: en ? 'Grow your level as you complete missions' : '내가 해결한 생활 미션이 기록으로 남아요',
              ),
              const Spacer(),
              PrimaryButton(
                label: en ? 'Continue with Google' : 'Google 계정으로 계속하기',
                icon: Icons.g_mobiledata_rounded,
                onTap: onLogin,
              ),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  en
                      ? 'By continuing, you agree to the Terms and Privacy Policy.'
                      : '로그인하면 서비스 이용약관과 개인정보처리방침에 동의하게 됩니다.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: C.gray,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
