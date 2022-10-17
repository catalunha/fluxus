import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class HealthPlanRepository {
  Future<List<HealthPlanModel>> list(QueryBuilder<ParseObject> query);
  Future<String> addEdit(HealthPlanModel model);
}
