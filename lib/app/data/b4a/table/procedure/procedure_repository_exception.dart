class ProcedureRepositoryException implements Exception {
  final String code;
  final String message;
  ProcedureRepositoryException({
    required this.code,
    required this.message,
  });
}
