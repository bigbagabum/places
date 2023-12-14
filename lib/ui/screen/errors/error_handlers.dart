import 'dart:async';

class ErrorManager {
  static final ErrorManager _instance = ErrorManager._internal();

  factory ErrorManager() {
    return _instance;
  }

  ErrorManager._internal();

  bool _isNetError = false;

  // StreamController для бродкаста ошибок
  final _errorStreamController = StreamController<bool>.broadcast();

  // Stream для прослушивания ошибок
  Stream<bool> get errorStream => _errorStreamController.stream;

  bool get netError => _isNetError;

  // Добавление ошибки в Stream
  void addError(bool isNetworkError) {
    _isNetError = isNetworkError;

    // Добавление в Stream
    _errorStreamController.add(_isNetError);
  }

  void dispose() {
    _errorStreamController.close();
  }
}

class NetworkException {
  final String requestName;
  final int errorCode;
  final String errorMessage;

  NetworkException({
    required this.requestName,
    required this.errorCode,
    required this.errorMessage,
  });

  @override
  String toString() {
    return "Выявлена ошибка в методе '$requestName' , код ошибки: $errorCode $errorMessage";
  }
}
