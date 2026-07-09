part of '../../../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.lang,
    required this.onLangChanged,
  });

  final AppLang lang;
  final ValueChanged<AppLang> onLangChanged;

  bool get en => lang == AppLang.en;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserProgressState>(
      valueListenable: userProgress,
      builder: (context, progress, _) {
        return PageShell(
          lang: lang,
          onLangChanged: onLangChanged,
          title: en ? 'Profile' : '프로필',
          subtitle: en ? 'Track your settlement progress.' : '나의 정착 성장 기록을 확인해요.',
          children: [
            ProfileCard(
              lang: lang,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PointHistoryScreen(lang: lang)),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BadgeCollectionScreen(lang: lang),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(28),
                    child: SummaryBox(
                      icon: Icons.workspace_premium_rounded,
                      title: en ? 'Badges' : '뱃지',
                      value: '-',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyPostsScreen(lang: lang),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(28),
                    child: ValueListenableBuilder<List<CommunityPost>>(
                      valueListenable: communityPosts,
                      builder: (context, posts, _) {
                        return SummaryBox(
                          icon: Icons.forum_rounded,
                          title: en ? 'Posts' : '게시글',
                          value: '${posts.length}',
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Header(title: en ? 'My activity' : '내 활동'),
            MenuTile(
              icon: Icons.flag_rounded,
              title: en ? 'Completed missions' : '완료한 미션',
              subtitle: en ? '${progress.completedCount} completed' : '${progress.completedCount}개 완료',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CompletedMissionsScreen(lang: lang),
                ),
              ),
            ),
            MenuTile(
              icon: Icons.workspace_premium_rounded,
              title: en ? 'Badges' : '획득한 뱃지',
              subtitle: en ? 'View your badges' : '획득한 뱃지 보기',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BadgeCollectionScreen(lang: lang),
                ),
              ),
            ),
            MenuTile(
              icon: Icons.language_rounded,
              title: en ? 'Language' : '언어 설정',
              subtitle: en ? 'English / Korean' : '한국어 / English',
              onTap: () => showLanguageSheet(context, lang, onLangChanged),
            ),
            MenuTile(
              icon: Icons.edit_note_rounded,
              title: en ? 'My posts' : '내가 쓴 글',
              subtitle: en
                  ? '${communityPosts.value.length} posts and comments'
                  : '${communityPosts.value.length}개 게시글과 댓글 보기',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MyPostsScreen(lang: lang),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
