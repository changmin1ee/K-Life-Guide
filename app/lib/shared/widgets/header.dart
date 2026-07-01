part of '../../main.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.title,
    this.action,
  });

  final String title;
  final String? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: C.black,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.6,
            ),
          ),
          if (action != null)
            Text(
              action!,
              style: const TextStyle(
                color: C.blue,
                fontWeight: FontWeight.w900,
              ),
            ),
        ],
      ),
    );
  }
}
