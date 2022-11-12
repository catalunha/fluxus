class ExpectRepositoryException implements Exception {
  final String code;
  final String message;
  ExpectRepositoryException({
    required this.code,
    required this.message,
  });
}
