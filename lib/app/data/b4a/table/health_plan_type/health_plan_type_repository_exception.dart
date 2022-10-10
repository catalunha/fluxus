class HealthPlanTypeRepositoryException implements Exception {
  final String code;
  final String message;
  HealthPlanTypeRepositoryException({
    required this.code,
    required this.message,
  });
}
