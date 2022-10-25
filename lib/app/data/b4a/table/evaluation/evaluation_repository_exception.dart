class EvaluationRepositoryException implements Exception {
  final String code;
  final String message;
  EvaluationRepositoryException({
    required this.code,
    required this.message,
  });
}
