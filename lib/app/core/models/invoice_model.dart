import 'package:fluxus/app/core/models/attendance_model.dart';

class InvoiceModel {
  final String? id;
  final List<AttendanceModel>? attendance;
  final DateTime? dStart;
  final DateTime? dEnd;
  final String? description;
  final bool? isDeleted;
}
