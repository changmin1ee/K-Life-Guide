part of '../../../main.dart';

final userProgress = ValueNotifier<UserProgressState>(const UserProgressState());
final memberName = ValueNotifier<String>('K-Life User');

// 앱 시작 시 또는 로그인 후 호출
Future<void> loadUserProgress() async {
  try {
    // 기본 프로필 로드
    final profileRes = await ApiClient.dio.get('/api/members/me');
    if (profileRes.data['isSuccess'] == true) {
      final data = profileRes.data['result'];
      memberName.value = data['name'] ?? 'K-Life User';

      // 완료 미션 로드
      Set<String> completedTitles = const <String>{};
      try {
        final completedRes =
            await ApiClient.dio.get('/api/members/me/missions/completed');
        if (completedRes.data['isSuccess'] == true) {
          final missions = completedRes.data['result'] as List;
          completedTitles = missions
              .map((m) => m['koTitle'] as String? ?? '')
              .where((t) => t.isNotEmpty)
              .toSet();
        }
      } catch (_) {}

      userProgress.value = UserProgressState(
        points: data['points'] ?? 0,
        xp: data['xp'] ?? 0,
        completedMissionTitles: completedTitles,
      );
    }
  } catch (_) {
    // 실패 시 기본값 유지
  }
}

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
