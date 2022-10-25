import 'package:fluxus/app/core/models/expertise_model.dart';

abstract class ExpertiseRepository {
  Future<List<ExpertiseModel>> list();
}
