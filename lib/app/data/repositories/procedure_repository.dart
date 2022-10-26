import 'package:fluxus/app/core/models/procedure_model.dart';

abstract class ProcedureRepository {
  Future<List<ProcedureModel>> list();
}
