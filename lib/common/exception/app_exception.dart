class AppException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  AppException([this.message, this.prefix, this.url]);

  @override
  String toString() {
    return message ?? "";
  }
}
