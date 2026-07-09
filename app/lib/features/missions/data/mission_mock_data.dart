part of '../../../main.dart';

// 미션 데이터는 백엔드 API에서 로드 (MissionRepository.getMissions())
// 하단 전역 ValueNotifier로 관리
final missionListNotifier = ValueNotifier<List<Mission>>([]);

// API 데이터를 Mission 모델로 변환
Mission missionFromApi(Map<String, dynamic> data) {
  final type = data['type'] == 'VERIFY' ? MissionType.verify : MissionType.guide;
  return Mission(
    id: data['id'] as int?,
    icon: _categoryIcon(data['koCategory'] ?? ''),
    type: type,
    koCategory: data['koCategory'] ?? '',
    enCategory: data['enCategory'] ?? '',
    koTitle: data['koTitle'] ?? '',
    enTitle: data['enTitle'] ?? '',
    koDesc: data['koDesc'] ?? '',
    enDesc: data['enDesc'] ?? '',
    xp: data['xp'] ?? 0,
    point: data['point'] ?? 0,
    progress: (data['myProgress'] ?? 0.0).toDouble(),
    koStatus: _mapStatusKo(data['myStatus'] as String?),
    enStatus: _mapStatusEn(data['myStatus'] as String?),
    koSteps: (data['steps'] as List<dynamic>?)
            ?.map((s) => s['koStep'] as String)
            .toList() ??
        [],
    enSteps: (data['steps'] as List<dynamic>?)
            ?.map((s) => s['enStep'] as String)
            .toList() ??
        [],
  );
}

String _mapStatusKo(String? status) => switch (status) {
  'IN_PROGRESS' => '진행 중',
  'COMPLETED'   => '완료',
  _             => '수락 가능',
};

String _mapStatusEn(String? status) => switch (status) {
  'IN_PROGRESS' => 'In Progress',
  'COMPLETED'   => 'Completed',
  _             => 'Available',
};

IconData _categoryIcon(String koCategory) {
  return switch (koCategory) {
    '교통' => Icons.credit_card_rounded,
    '음식' => Icons.restaurant_rounded,
    '행정' => Icons.badge_rounded,
    '생활' => Icons.home_rounded,
    '안전' => Icons.contact_phone_rounded,
    _ => Icons.flag_rounded,
  };
}

// 하위 호환을 위해 missions getter 유지
List<Mission> get missions => missionListNotifier.value;
