import 'package:dio/dio.dart';
import 'token_storage.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:8080';
  // 'http://10.0.2.2:8080'; // Android 에뮬레이터 → localhost
  // iOS 시뮬레이터는 'http://localhost:8080' 사용
  // 실기기 테스트는 컴퓨터 IP로 변경 (예: 'http://192.168.1.x:8080')

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ))
    ..interceptors.add(_AuthInterceptor());

  static Dio get dio => _dio;
}

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await TokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 401이면 토큰 만료 → 로그아웃 처리는 각 화면에서
    handler.next(err);
  }
}
