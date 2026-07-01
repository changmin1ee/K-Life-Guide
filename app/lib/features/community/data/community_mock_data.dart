part of '../../../main.dart';

final communityPosts = ValueNotifier<List<CommunityPost>>([
  CommunityPost(
    board: BoardFilter.qna,
    titleKo: 'T머니 충전은 어디서 할 수 있나요?',
    titleEn: 'Where can I top up T-money?',
    metaKo: '댓글 3 · 추천 5 · 해결됨',
    metaEn: '3 replies · 5 likes · Solved',
    solved: true,
  ),
  CommunityPost(
    board: BoardFilter.qna,
    titleKo: '외국인등록증 예약은 어떻게 하나요?',
    titleEn: 'How do I reserve an ARC visit?',
    metaKo: '댓글 8 · 추천 12 · 행정',
    metaEn: '8 replies · 12 likes · Admin',
  ),
  CommunityPost(
    board: BoardFilter.qna,
    titleKo: '배달앱 주소 입력이 계속 실패해요',
    titleEn: 'My delivery address keeps failing',
    metaKo: '댓글 4 · 추천 9 · 배달',
    metaEn: '4 replies · 9 likes · Delivery',
  ),
  CommunityPost(
    board: BoardFilter.free,
    titleKo: '처음 한국 지하철을 타본 후기',
    titleEn: 'My first time using the Korean subway',
    metaKo: '댓글 2 · 추천 7',
    metaEn: '2 replies · 7 likes',
  ),
  CommunityPost(
    board: BoardFilter.free,
    titleKo: '편의점에서 자주 쓰는 말 정리',
    titleEn: 'Useful words at convenience stores',
    metaKo: '댓글 1 · 추천 4',
    metaEn: '1 reply · 4 likes',
  ),

]);
