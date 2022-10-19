class RoomRepositoryException implements Exception {
  final String code;
  final String message;
  RoomRepositoryException({
    required this.code,
    required this.message,
  });
}
