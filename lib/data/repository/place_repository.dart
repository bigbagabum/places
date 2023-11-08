import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:places/data/error_handlers.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/domain/sight.dart';

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
          final NetworkException err = NetworkException(
              requestName: dioError.requestOptions.path,
              errorCode: dioError.response?.statusCode ?? 0,
              errorMessage: dioError.message.toString());
          // Вывести информацию при возникновении ошибки
          print(err.toString());
          handler.next(dioError);
        },
      ),
    );
  }

// получить список мест по фильтру
  Future<List<PlaceDto>> filteredPlaces(Map<String, dynamic> data) async {
    try {
      final response = await _dio.request('/filtered_places',
          data: jsonEncode(data),
          options:
              Options(contentType: Headers.jsonContentType, method: 'POST'));

      if (response.statusCode == 200) {
        // Если статус ответа успешный (200 OK)
        final List<dynamic> data = response.data;
        final List<PlaceDto> places =
            data.map((json) => PlaceDto.fromJson(json)).toList();
        return places;
      } else {
        throw NetworkException(
            requestName: '/filtered_places',
            errorCode: response.statusCode ?? 0,
            errorMessage: response.statusMessage ?? 'unknown error');
      }
    } on NetworkException catch (error) {
      print(error.toString()); // Используется переопределенный метод toString
      rethrow;
    }
  }

  //создать новое место
  Future<void> newPlace(Place data) async {
    try {
      final response = await _dio.request('/place',
          data: jsonEncode(data),
          options:
              Options(contentType: Headers.jsonContentType, method: 'POST'));

      if (response.statusCode == 200) {
        print('Place created successfully');
      } else if (response.statusCode == 400) {
        print('Invalid request');
      } else if (response.statusCode == 409) {
        print('Object already exists');
      } else {
        throw Exception('Failed to create place');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  // получить список мест
  Future<List<Place>> getListPlaces(Map<String, dynamic> data) async {
    try {
      final response = await _dio.request('/places',
          data: jsonEncode(data),
          options:
              Options(contentType: Headers.jsonContentType, method: 'GET'));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Place> places =
            data.map((json) => Place.fromJson(json)).toList();
        return places;
      } else {
        throw Exception('Failed to fetch places');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  //получаем объект по id
  Future<Sight> getPlaceById(String id) async {
    try {
      final uri = Uri.parse('/place/$id');
      final response = await _dio.getUri(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return Sight.fromJson(data);
      } else if (response.statusCode == 404) {
        print('Object not found');
        throw Exception('Object not found');
      } else {
        throw Exception('Failed to fetch place');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  //удалем мето по id
  Future<void> deletePlaceById(String id) async {
    try {
      final uri = Uri.parse('/place/$id');
      final response = await _dio.deleteUri(uri);

      if (response.statusCode == 200) {
        print('Object successfully deleted');
      } else if (response.statusCode == 404) {
        print('Object not found');
        throw Exception('Object not found');
      } else {
        throw Exception('Failed to delete place');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  //обновить мест по id

  Future<Place> updatePlaceById(String id, Place updatedPlace) async {
    try {
      final uri = Uri.parse('/place/$id');
      final response = await _dio.putUri(uri,
          data: updatedPlace.toJson(),
          options: Options(
            contentType: Headers.jsonContentType,
          ));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return Place.fromJson(data);
      } else if (response.statusCode == 400) {
        print('Invalid request');
        throw Exception('Invalid request');
      } else if (response.statusCode == 404) {
        print('Object not found');
        throw Exception('Object not found');
      } else if (response.statusCode == 409) {
        print('Object already exists');
        throw Exception('Object already exists');
      } else {
        throw Exception('Failed to update place');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }

  //Media upload
  Future<List<String>> uploadFiles(List<MultipartFile> files) async {
    try {
      final formData = FormData.fromMap({
        'file': files,
      });

      final response = await _dio.post('/upload_file', data: formData);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<String> fileUrls =
            data.map((url) => url.toString()).toList();
        return fileUrls;
      } else if (response.statusCode == 201) {
        final String fileUrl = response.headers['location']?.toString() ?? '';
        return [fileUrl];
      } else {
        throw Exception('Failed to upload files');
      }
    } catch (error) {
      throw Exception('Network error: $error');
    }
  }
}
