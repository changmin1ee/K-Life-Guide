part of '../../../../main.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.board,
    required this.title,
    required this.meta,
    required this.onTap,
  });

  final String board;
  final String title;
  final String meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListRow(
      textIcon: board.substring(0, 1),
      iconColor: C.blue,
      iconBg: C.blueSoft,
      title: title,
      subtitle: meta,
      onTap: onTap,
    );
  }
}
