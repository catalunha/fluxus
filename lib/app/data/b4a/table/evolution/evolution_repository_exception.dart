class EvolutionRepositoryException implements Exception {
  final String code;
  final String message;
  EvolutionRepositoryException({
    required this.code,
    required this.message,
  });
}
