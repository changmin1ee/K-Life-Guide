import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';

class MissionRepository {
  static Future<List<Map<String, dynamic>>> getMissions({String? type}) async {
    try {
      final params = type != null ? {'type': type} : null;
      final res = await ApiClient.dio.get('/api/missions', queryParameters: params);
      if (res.data['isSuccess'] == true) {
        return List<Map<String, dynamic>>.from(res.data['result']);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getMissionDetail(int missionId) async {
    try {
      final res = await ApiClient.dio.get('/api/missions/$missionId');
      if (res.data['isSuccess'] == true) return res.data['result'];
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> startMission(int missionId) async {
    try {
      final res = await ApiClient.dio.post('/api/missions/$missionId/start');
      return res.data['isSuccess'] == true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> completeMission(
      int missionId, {String? proofImageUrl}) async {
    try {
      final res = await ApiClient.dio.post(
        '/api/missions/$missionId/complete',
        data: {'proofImageUrl': proofImageUrl},
      );
      if (res.data['isSuccess'] == true) return res.data['result'];
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getMyMissions() async {
    try {
      final res = await ApiClient.dio.get('/api/members/me/missions');
      if (res.data['isSuccess'] == true) {
        return List<Map<String, dynamic>>.from(res.data['result']);
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
