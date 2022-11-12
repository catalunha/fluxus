import 'package:fluxus/app/core/models/expect_model.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class ExpectRepository {
  Future<List<ExpectModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination);
  Future<String> update(ExpectModel model);
  Future<void> updateUnset(String modelId, List<String> unsetFields);
  Future<ExpectModel?> readById(String id);
}
