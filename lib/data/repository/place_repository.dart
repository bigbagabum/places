import 'dart:convert';

import 'package:dio/dio.dart';

class PlaceRepository {
  final Dio _dio = Dio();

  PlaceRepository() {
    _dio.options.baseUrl = 'https://test-backend-flutter.surfstudio.ru/';
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 5000);
    _dio.options.sendTimeout = const Duration(milliseconds: 5000);
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.add(LogInterceptor(responseBody: true));

    _dio.interceptors.add(
      InterceptorsWrapper(
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
      ),
    );
  }

// запросы
  Future<void> filteredPlaces(Map<String, dynamic> data) async {
    try {
      final uri = Uri.parse('/filtered_places');
      final response = await _dio.postUri(uri,
          data: jsonEncode(data),
          options: Options(contentType: Headers.jsonContentType));

      if (response.statusCode == 200) {
        // Если статус ответа успешный (200 OK)
        print('Response Data: ${response.toString()}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
