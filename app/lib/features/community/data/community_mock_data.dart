part of '../../../main.dart';

// 커뮤니티 게시글은 백엔드 API에서 로드
final communityPosts = ValueNotifier<List<CommunityPost>>([]);

// API 응답 → CommunityPost 변환
CommunityPost postFromApi(Map<String, dynamic> data) {
  final boardType =
      data['boardType'] == 'QNA' ? BoardFilter.qna : BoardFilter.free;
  return CommunityPost(
    id: data['id']?.toString(),
    board: boardType,
    titleKo: data['titleKo'] ?? '',
    titleEn: data['titleEn'] ?? '',
    contentKo: data['contentKo'],
    contentEn: data['contentEn'],
    authorName: data['authorName'] ?? '',
    replyCount: data['replyCount'] ?? 0,
    likeCount: data['likeCount'] ?? 0,
    isLiked: data['isLiked'] ?? false,
    solved: data['solved'] ?? false,
  );
}
