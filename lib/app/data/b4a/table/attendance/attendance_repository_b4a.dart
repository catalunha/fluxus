import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/data/b4a/entity/attendance_entity.dart';
import 'package:fluxus/app/data/b4a/table/attendance/attendance_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/parse_error_code.dart';
import 'package:fluxus/app/data/repositories/attendance_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AttendanceRepositoryB4a implements AttendanceRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.whereEqualTo('isDeleted', false);
    query.orderByDescending('updatedAt');
    query.includeObject([
      'professional',
      'procedure',
      'patient',
      'healthPlan',
      'healthPlan.healthPlanType',
      'status'
    ]);

    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<AttendanceModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = response = await query2.query();
      List<AttendanceModel> listTemp = <AttendanceModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(AttendanceEntity().fromParse(element));
        }
        return listTemp;
      }
      return listTemp;
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw AttendanceRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(AttendanceModel model) async {
    final parseObject = AttendanceEntity().toParse(model);
    final ParseResponse response = await parseObject.save();

    if (response.success && response.results != null) {
      ParseObject userProfile = response.results!.first as ParseObject;
      return userProfile.objectId!;
    } else {
      var errorCodes = ParseErrorCode(response.error!);
      throw AttendanceRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<void> updateUnset(String modelId, List<String> unsetFields) async {
    final parseObject = AttendanceEntity().toParseUnset(modelId, unsetFields);
    await parseObject.save();

    // if (response.success && response.results != null) {
    //   ParseObject userProfile = response.results!.first as ParseObject;
    //   return userProfile.objectId!;
    // } else {
    //   var errorCodes = ParseErrorCode(response.error!);
    //   throw AttendanceRepositoryException(
    //     code: errorCodes.code,
    //     message: errorCodes.message,
    //   );
    // }
  }

  @override
  Future<AttendanceModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    query.whereEqualTo('objectId', id);
    query.includeObject([
      'professional',
      'procedure',
      'patient',
      'healthPlan',
      'healthPlan.healthPlanType',
      'status'
    ]);
    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return AttendanceEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw AttendanceRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
