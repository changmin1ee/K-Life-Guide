part of '../../../main.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({super.key, required this.lang});
  final AppLang lang;
  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  bool get en => widget.lang == AppLang.en;
  List<CommunityPost> _posts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMyPosts();
  }

  Future<void> _loadMyPosts() async {
    try {
      final res = await ApiClient.dio.get('/api/members/me/posts');
      if (res.data['isSuccess'] == true) {
        setState(() {
          _posts = (res.data['result'] as List)
              .map((d) => postFromApi(d as Map<String, dynamic>))
              .toList();
          _loading = false;
        });
        return;
      }
    } catch (_) {}
    setState(() => _loading = false);
  }

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
              Header(title: en ? 'Recent posts' : '최근 작성 글', action: '${_posts.length}'),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_posts.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      en ? 'No posts yet.' : '아직 작성한 글이 없어요.',
                      style: const TextStyle(color: C.gray, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              else
                ..._posts.map(
                  (post) => PostTile(
                    board: post.board == BoardFilter.qna ? 'Q&A' : 'FREE',
                    title: post.title(widget.lang),
                    meta: post.meta(widget.lang),
                    onTap: () => openPost(context, post.title(widget.lang), widget.lang),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
