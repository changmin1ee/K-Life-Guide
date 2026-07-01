part of '../../../main.dart';

class Mission {
  const Mission({
    required this.icon,
    required this.type,
    required this.koCategory,
    required this.enCategory,
    required this.koTitle,
    required this.enTitle,
    required this.koDesc,
    required this.enDesc,
    required this.xp,
    required this.point,
    required this.progress,
    required this.koStatus,
    required this.enStatus,
    required this.koSteps,
    required this.enSteps,
  });

  final IconData icon;
  final MissionType type;
  final String koCategory;
  final String enCategory;
  final String koTitle;
  final String enTitle;
  final String koDesc;
  final String enDesc;
  final int xp;
  final int point;
  final double progress;
  final String koStatus;
  final String enStatus;
  final List<String> koSteps;
  final List<String> enSteps;

  String category(AppLang lang) => lang == AppLang.ko ? koCategory : enCategory;
  String title(AppLang lang) => lang == AppLang.ko ? koTitle : enTitle;
  String desc(AppLang lang) => lang == AppLang.ko ? koDesc : enDesc;
  String status(AppLang lang) => lang == AppLang.ko ? koStatus : enStatus;
  List<String> steps(AppLang lang) => lang == AppLang.ko ? koSteps : enSteps;
}
