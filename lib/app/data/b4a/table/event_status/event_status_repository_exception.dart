class EventStatusRepositoryException implements Exception {
  final String code;
  final String message;
  EventStatusRepositoryException({
    required this.code,
    required this.message,
  });
}
