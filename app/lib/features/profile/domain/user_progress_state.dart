part of '../../../main.dart';

class UserProgressState {
  const UserProgressState({
    this.points = 0,
    this.xp = 0,
    this.completedMissionTitles = const <String>{},
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
