class AttendanceRepositoryException implements Exception {
  final String code;
  final String message;
  AttendanceRepositoryException({
    required this.code,
    required this.message,
  });
}
