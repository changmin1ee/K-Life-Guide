part of '../../../main.dart';

class CommunityPost {
  const CommunityPost({
    required this.board,
    required this.titleKo,
    required this.titleEn,
    required this.metaKo,
    required this.metaEn,
    this.solved = false,
  });

  final BoardFilter board;
  final String titleKo;
  final String titleEn;
  final String metaKo;
  final String metaEn;
  final bool solved;

  String title(AppLang lang) => lang == AppLang.ko ? titleKo : titleEn;
  String meta(AppLang lang) => lang == AppLang.ko ? metaKo : metaEn;
}
