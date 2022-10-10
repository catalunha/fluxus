import 'package:fluxus/app/core/models/health_plan_type_model.dart';

abstract class HealthPlanTypeRepository {
  Future<List<HealthPlanTypeModel>> list();
}
