import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/api_endpoints.dart';
import '../network/token_storage.dart';

class AuthService {
  static final _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  /// Google 로그인 → 백엔드 JWT 발급
  /// 성공 시 true, 실패 시 false 반환
  static Future<bool> signInWithGoogle() async {
    // 웹 환경에서는 dev-login으로 우회 (Google OAuth 설정 전 테스트용)
    if (kIsWeb) {
      return _devLogin('test@test.com');
    }

    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('[Auth] googleUser null (취소 또는 오류)');
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      debugPrint('[Auth] idToken: ${idToken == null ? "null → dev-login 폴백" : "있음"}');

      if (idToken == null) {
        return _devLogin(googleUser.email);
      }

      final response = await ApiClient.dio.post(
        ApiEndpoints.googleLogin,
        data: {'idToken': idToken},
      );

      if (response.data['isSuccess'] == true) {
        final result = response.data['result'];
        await TokenStorage.saveTokens(
          accessToken: result['accessToken'],
          refreshToken: result['refreshToken'],
        );
        return true;
      }
      return _devLogin(googleUser.email);
    } catch (e) {
      debugPrint('[Auth] 예외 발생: $e → dev-login 폴백');
      // ApiException: 10 (SHA-1 미등록 등) → dev-login으로 폴백
      return _devLogin('test@klife.com');
    }
  }

  /// 개발용 로그인 (백엔드 dev-login 엔드포인트)
  static Future<bool> _devLogin(String email) async {
    try {
      debugPrint('[Auth] dev-login 시도: $email → ${ApiClient.baseUrl}');
      final response = await ApiClient.dio.post(
        '/api/auth/dev-login',
        queryParameters: {'email': email},
      );
      debugPrint('[Auth] dev-login 응답: ${response.data}');
      if (response.data['isSuccess'] == true) {
        final result = response.data['result'];
        await TokenStorage.saveTokens(
          accessToken: result['accessToken'],
          refreshToken: result['refreshToken'],
        );
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('[Auth] dev-login 실패: $e');
      return false;
    }
  }

  /// 로그아웃
  static Future<void> signOut() async {
    try {
      await ApiClient.dio.post(ApiEndpoints.logout);
    } catch (_) {}
    await _googleSignIn.signOut();
    await TokenStorage.clearAll();
  }

  /// 앱 시작 시 토큰 존재 여부로 로그인 상태 확인
  static Future<bool> isLoggedIn() async {
    final token = await TokenStorage.getAccessToken();
    return token != null;
  }
}
