import 'package:dio/dio.dart';

class DioUtils {
  DioUtils({
    required Dio dio,
    bool logging = false,
  }) {
    _dio = dio;

    if (logging) {
      _dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  late Dio _dio;

  Options _dioOptions({
    String? contentType,
    ResponseType type = ResponseType.json,
  }) {
    return Options(
      contentType: contentType,
      responseType: type,
      validateStatus: (status) => status != null && status < 400,
    );
  }

  Future<Response<T>> getQuery<T>(
    String apiPath, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get<T>(
      apiPath,
      queryParameters: queryParameters,
      options: _dioOptions(),
    );
  }
}
