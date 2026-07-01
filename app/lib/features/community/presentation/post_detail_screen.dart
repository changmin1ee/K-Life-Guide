part of '../../../main.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({
    super.key,
    required this.title,
    required this.lang,
  });

  final String title;
  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  color: C.black,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                en ? 'Alex Kim · Lv.3 · just now' : 'Alex Kim · Lv.3 · 방금 전',
                style: const TextStyle(
                  color: C.gray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              TossCard(
                child: Text(
                  en
                      ? 'This is a sample post screen for checking the final community design. Reply, like, and report flows can be connected later.'
                      : '처음 한국 생활을 시작하는 외국인 입장에서 헷갈릴 수 있는 내용을 질문하는 예시 화면입니다. 댓글과 추천, 신고 버튼까지 디자인 확인이 가능하도록 구성했습니다.',
                  style: const TextStyle(
                    color: C.black,
                    height: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PostActionBar(lang: lang),
              Header(title: en ? 'Replies' : '댓글'),
              TossCard(
                padding: const EdgeInsets.all(16),
                child: Text(
                  en
                      ? 'Mina · You can also top up at convenience stores.'
                      : 'Mina · 편의점에서도 가능해요. 직원에게 T-money charge라고 말하면 됩니다.',
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: en ? 'Write reply' : '댓글 작성하기',
                icon: Icons.chat_bubble_rounded,
                onTap: () => toast(
                  context,
                  en ? 'Reply input opened.' : '댓글 입력창을 엽니다.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostActionBar extends StatefulWidget {
  const PostActionBar({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<PostActionBar> createState() => _PostActionBarState();
}

class _PostActionBarState extends State<PostActionBar> {
  bool liked = false;
  bool saved = false;

  bool get en => widget.lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MiniActionButton(
            icon: liked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
            label: liked ? (en ? 'Liked' : '추천됨') : (en ? 'Like' : '추천'),
            active: liked,
            onTap: () => setState(() => liked = !liked),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: MiniActionButton(
            icon: saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            label: saved ? (en ? 'Saved' : '저장됨') : (en ? 'Save' : '저장'),
            active: saved,
            onTap: () => setState(() => saved = !saved),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: MiniActionButton(
            icon: Icons.report_gmailerrorred_rounded,
            label: en ? 'Report' : '신고',
            active: false,
            onTap: () => toast(context, en ? 'Report received.' : '신고가 접수되었습니다.'),
          ),
        ),
      ],
    );
  }
}

class MiniActionButton extends StatelessWidget {
  const MiniActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: active ? C.blueSoft : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: active ? C.blueSoft : C.light),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: active ? C.blue : C.gray),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: active ? C.blue : C.gray,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
