class ExpertiseRepositoryException implements Exception {
  final String code;
  final String message;
  ExpertiseRepositoryException({
    required this.code,
    required this.message,
  });
}
