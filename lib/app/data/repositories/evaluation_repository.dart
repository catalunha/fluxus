import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class EvaluationRepository {
  Future<List<EvaluationModel>> list(
      QueryBuilder<ParseObject> query, Pagination pagination);
  Future<String> update(EvaluationModel model);
  Future<EvaluationModel?> readById(String id);
}
