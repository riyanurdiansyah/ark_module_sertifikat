class CustomException implements Exception {
  int code;
  String message;
  CustomException(this.code, this.message);
}
