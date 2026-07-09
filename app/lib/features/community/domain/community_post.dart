part of '../../../main.dart';

class CommunityPost {
  const CommunityPost({
    this.id,
    required this.board,
    required this.titleKo,
    required this.titleEn,
    this.contentKo,
    this.contentEn,
    this.authorName = '',
    this.replyCount = 0,
    this.likeCount = 0,
    this.isLiked = false,
    this.solved = false,
  });

  final String? id;
  final BoardFilter board;
  final String titleKo;
  final String titleEn;
  final String? contentKo;
  final String? contentEn;
  final String authorName;
  final int replyCount;
  final int likeCount;
  final bool isLiked;
  final bool solved;

  String title(AppLang lang) => lang == AppLang.ko ? titleKo : titleEn;

  // 기존 meta 문자열 computed (하위 호환)
  String metaKo(AppLang lang) =>
      '댓글 $replyCount · 추천 $likeCount${solved ? ' · 해결됨' : ''}';
  String metaEn(AppLang lang) =>
      '$replyCount replies · $likeCount likes${solved ? ' · Solved' : ''}';
  String meta(AppLang lang) =>
      lang == AppLang.ko ? metaKo(lang) : metaEn(lang);
}
