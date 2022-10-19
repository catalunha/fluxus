class EventRepositoryException implements Exception {
  final String code;
  final String message;
  EventRepositoryException({
    required this.code,
    required this.message,
  });
}
