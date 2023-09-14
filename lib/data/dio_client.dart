import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    _dio.options.baseUrl = 'https://test-backend-flutter.surfstudio.ru';
    _dio.options.connectTimeout = 5000 as Duration;
    _dio.options.receiveTimeout = 5000 as Duration;
    _dio.options.sendTimeout = 5000 as Duration;
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.add(LogInterceptor(responseBody: true));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Вывести информацию перед отправкой запроса
        print('Request URL: ${options.uri}');
        print('Request Method: ${options.method}');
        print('Request Headers: ${options.headers}');
        print('Request Data: ${options.data}');
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // Вывести информацию после получения ответа
        print('Response Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');
        handler.next(response);
      },
      onError: (DioException dioError, ErrorInterceptorHandler handler) {
        // Вывести информацию при возникновении ошибки
        print('Request Error: ${dioError.message}');
        handler.next(dioError);
      },
    ));
  }
}
