part of '../../../main.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  BoardFilter filter = BoardFilter.qna;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts([String? boardType]) async {
    try {
      final params = boardType != null ? {'boardType': boardType} : null;
      final res =
          await ApiClient.dio.get('/api/posts', queryParameters: params);
      if (res.data['isSuccess'] == true) {
        communityPosts.value = (res.data['result'] as List)
            .map((d) => postFromApi(d as Map<String, dynamic>))
            .toList();
        if (mounted) setState(() {});
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final en = widget.lang == AppLang.en;

    return ValueListenableBuilder<List<CommunityPost>>(
      valueListenable: communityPosts,
      builder: (context, allPosts, _) {
        final posts = allPosts.where((p) => p.board == filter).toList();
        final solvedCount = allPosts.where((p) => p.solved).length;

        return PageShell(
          lang: widget.lang,
          onLangChanged: widget.onLangChanged,
          title: en ? 'Community' : '커뮤니티',
          subtitle: en ? 'Ask questions and share local tips.' : '혼자 해결하기 어려운 한국 생활 문제를 물어보세요.',
          children: [
            CommunityPulseCard(
              lang: widget.lang,
              postCount: allPosts.length,
              solvedCount: solvedCount,
            ),
            const SizedBox(height: 14),
            FilterBar(
              labels: en ? const ['Free board', 'Q&A'] : const ['자유게시판', 'Q&A'],
              selected: filter.index,
              onTap: (i) => setState(() => filter = BoardFilter.values[i]),
            ),
            Header(
              title: filter == BoardFilter.qna
                  ? (en ? 'Real-life Q&A' : '실생활 질문')
                  : (en ? 'Free board' : '자유게시판'),
              action: '${posts.length}',
            ),
            if (posts.isEmpty)
              TossCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconBox(
                      icon: Icons.chat_bubble_outline_rounded,
                      color: C.gray,
                      bg: C.inkSoft,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      en ? 'No posts yet' : '아직 게시글이 없습니다',
                      style: const TextStyle(
                        color: C.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      en
                          ? 'Write the first question about life in Korea.'
                          : '주소 입력, 병원 접수, 행정 예약처럼 막힌 부분을 자세히 적어보세요.',
                      style: const TextStyle(
                        color: C.gray,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ...posts.map(
              (p) => PostTile(
                board: p.board == BoardFilter.qna ? 'Q&A' : 'FREE',
                title: p.title(widget.lang),
                meta: p.meta(widget.lang),
                onTap: () => openPost(context, p.title(widget.lang), widget.lang),
              ),
            ),
            const SizedBox(height: 18),
            PrimaryButton(
              label: en ? 'Write post' : '글쓰기',
              icon: Icons.edit_rounded,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WritePostScreen(lang: widget.lang),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
