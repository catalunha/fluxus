class HealthPlanRepositoryException implements Exception {
  final String code;
  final String message;
  HealthPlanRepositoryException({
    required this.code,
    required this.message,
  });
}
