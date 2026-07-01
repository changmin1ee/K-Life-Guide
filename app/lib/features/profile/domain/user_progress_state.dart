part of '../../../main.dart';

class UserProgressState {
  const UserProgressState({
    this.points = 2840,
    this.xp = 680,
    this.completedMissionTitles = const <String>{
      '지하철 노선 확인하기',
      '분리수거 방법 익히기',
      '편의점에서 상품 구매하기',
    },
  });

  final int points;
  final int xp;
  final Set<String> completedMissionTitles;

  int get level => 3 + (xp ~/ 500);
  int get completedCount => completedMissionTitles.length;

  UserProgressState copyWith({
    int? points,
    int? xp,
    Set<String>? completedMissionTitles,
  }) {
    return UserProgressState(
      points: points ?? this.points,
      xp: xp ?? this.xp,
      completedMissionTitles: completedMissionTitles ?? this.completedMissionTitles,
    );
  }
}
