part of '../../../../main.dart';

class DoneTile extends StatelessWidget {
  const DoneTile({
    super.key,
    required this.title,
    required this.lang,
  });

  final String title;
  final AppLang lang;

  @override
  Widget build(BuildContext context) {
    return ListRow(
      icon: Icons.check_rounded,
      iconColor: C.blue,
      iconBg: C.blueSoft,
      title: title,
      subtitle: lang == AppLang.en ? 'Completed · Reward received' : '완료됨 · 보상 지급 완료',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CompletedMissionsScreen(lang: lang),
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListRow(
      icon: icon,
      iconColor: C.blue,
      iconBg: C.blueSoft,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}

class ListRow extends StatelessWidget {
  const ListRow({
    super.key,
    this.icon,
    this.textIcon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData? icon;
  final String? textIcon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: TossCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: textIcon != null
                      ? Text(
                          textIcon!,
                          style: TextStyle(
                            color: iconColor,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      : Icon(icon, color: iconColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: C.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: C.gray,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: C.gray),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryBox extends StatelessWidget {
  const SummaryBox({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TossCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: C.blue),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              color: C.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: C.gray,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
