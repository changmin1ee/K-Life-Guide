part of '../../../main.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({
    super.key,
    required this.post,
    required this.lang,
  });

  final CommunityPost post;
  final AppLang lang;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  bool get en => widget.lang == AppLang.en;

  // 상세 데이터 (API에서 로드)
  String? _contentKo;
  String? _contentEn;
  String _authorName = '';
  bool _isLiked = false;
  int _likeCount = 0;
  List<Map<String, dynamic>> _replies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    if (widget.post.id == null) {
      setState(() => _loading = false);
      return;
    }
    try {
      final res = await ApiClient.dio.get('/api/posts/${widget.post.id}');
      if (res.data['isSuccess'] == true) {
        final d = res.data['result'] as Map<String, dynamic>;
        setState(() {
          _contentKo = d['contentKo'] as String?;
          _contentEn = d['contentEn'] as String?;
          _authorName = d['authorName'] ?? '';
          _isLiked = d['isLiked'] ?? false;
          _likeCount = d['likeCount'] ?? 0;
          _replies = ((d['replies'] as List?) ?? [])
              .map((r) => r as Map<String, dynamic>)
              .toList();
          _loading = false;
        });
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  Future<void> _toggleLike() async {
    if (widget.post.id == null) return;
    try {
      final res =
          await ApiClient.dio.post('/api/posts/${widget.post.id}/like');
      if (res.data['isSuccess'] == true) {
        final d = res.data['result'] as Map<String, dynamic>;
        setState(() {
          _isLiked = d['isLiked'] ?? _isLiked;
          _likeCount = d['likeCount'] ?? _likeCount;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.post.title(widget.lang);
    final content = (en ? _contentEn : _contentKo) ?? '';

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
              // 제목
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
              // 작성자
              Text(
                _loading ? '' : _authorName,
                style: const TextStyle(
                  color: C.gray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              // 본문
              if (_loading)
                const Center(
                    child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ))
              else ...[
                TossCard(
                  child: Text(
                    content.isNotEmpty
                        ? content
                        : (en ? '(No content)' : '(내용 없음)'),
                    style: const TextStyle(
                      color: C.black,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // 액션바 (좋아요 / 저장 / 신고)
                _PostActionBar(
                  lang: widget.lang,
                  isLiked: _isLiked,
                  likeCount: _likeCount,
                  onLikeTap: _toggleLike,
                ),
                // 댓글
                Header(title: en ? 'Replies' : '댓글'),
                if (_replies.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      en ? 'No replies yet.' : '아직 댓글이 없습니다.',
                      style: const TextStyle(color: C.gray, fontWeight: FontWeight.w600),
                    ),
                  )
                else
                  ..._replies.map((r) => _ReplyTile(reply: r, lang: widget.lang)),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _PostActionBar extends StatelessWidget {
  const _PostActionBar({
    required this.lang,
    required this.isLiked,
    required this.likeCount,
    required this.onLikeTap,
  });

  final AppLang lang;
  final bool isLiked;
  final int likeCount;
  final VoidCallback onLikeTap;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MiniActionButton(
            icon: isLiked ? Icons.thumb_up_rounded : Icons.thumb_up_outlined,
            label: isLiked
                ? (en ? 'Liked ($likeCount)' : '추천됨 ($likeCount)')
                : (en ? 'Like' : '추천'),
            active: isLiked,
            onTap: onLikeTap,
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

class _ReplyTile extends StatelessWidget {
  const _ReplyTile({required this.reply, required this.lang});

  final Map<String, dynamic> reply;
  final AppLang lang;

  @override
  Widget build(BuildContext context) {
    final author = reply['authorName'] as String? ?? '';
    final content = reply['content'] as String? ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TossCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              author,
              style: const TextStyle(
                color: C.black,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              content,
              style: const TextStyle(
                color: C.black,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
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
