part of '../../../main.dart';

final userProgress = ValueNotifier<UserProgressState>(const UserProgressState());

bool isMissionCompleted(Mission mission) {
  return userProgress.value.completedMissionTitles.contains(mission.koTitle);
}

void completeMission(Mission mission) {
  final current = userProgress.value;
  if (current.completedMissionTitles.contains(mission.koTitle)) {
    return;
  }

  userProgress.value = current.copyWith(
    points: current.points + mission.point,
    xp: current.xp + mission.xp,
    completedMissionTitles: {
      ...current.completedMissionTitles,
      mission.koTitle,
    },
  );
}
