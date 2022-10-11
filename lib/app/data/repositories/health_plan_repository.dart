import 'package:fluxus/app/core/models/health_plan_model.dart';

abstract class HealthPlanRepository {
  // Future<List<HealthPlanModel>> list(String profileId);
  Future<String> addEdit(HealthPlanModel model);
}
