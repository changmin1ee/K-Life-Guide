part of '../../../main.dart';

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    final posts = [
      [
        en ? 'My first time using the Korean subway' : '처음 한국 지하철을 타본 후기',
        en ? 'Free board · 2 replies' : '자유게시판 · 댓글 2',
      ],
      [
        en ? 'Where can I top up T-money?' : 'T머니 충전은 어디서 할 수 있나요?',
        en ? 'Q&A · 3 replies' : 'Q&A · 댓글 3',
      ],
      [
        en ? 'Useful words at convenience stores' : '편의점에서 자주 쓰는 말 정리',
        en ? 'Free board · 1 reply' : '자유게시판 · 댓글 1',
      ],
    ];

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
              const SizedBox(height: 18),
              Text(
                en ? 'My posts' : '내가 쓴 글',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en ? 'Posts and questions you wrote.' : '내가 작성한 게시글과 질문을 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Header(title: en ? 'Recent posts' : '최근 작성 글', action: '${posts.length}'),
              ...posts.map(
                (post) => PostTile(
                  board: post[1].contains('Q&A') ? 'Q&A' : 'FREE',
                  title: post[0],
                  meta: post[1],
                  onTap: () => openPost(context, post[0], lang),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
