class OfficeRepositoryException implements Exception {
  final String code;
  final String message;
  OfficeRepositoryException({
    required this.code,
    required this.message,
  });
}
