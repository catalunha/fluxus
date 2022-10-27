import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class AttendanceRepository {
  Future<List<AttendanceModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination);
  Future<String> update(AttendanceModel model);
  Future<AttendanceModel?> readById(String id);
}
