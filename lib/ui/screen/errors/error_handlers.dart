class NetworkException implements Exception {
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
