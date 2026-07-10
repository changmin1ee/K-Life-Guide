import 'package:dio/dio.dart';
import 'token_storage.dart';

class ApiClient {
  // 실기기: adb reverse tcp:8080 tcp:8080 실행 후 localhost 사용
  static const String baseUrl = 'http://localhost:8080';
  // 에뮬레이터: 'http://10.0.2.2:8080'
  // 직접 IP: 'http://172.29.66.110:8080'

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
