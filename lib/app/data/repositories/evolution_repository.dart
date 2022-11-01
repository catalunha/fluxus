import 'package:fluxus/app/core/models/evolution_model.dart';

abstract class EvolutionRepository {
  Future<List<EvolutionModel>> list(String professionalId);
  Future<String> update(EvolutionModel model);
  Future<EvolutionModel?> readById(String id);
  // Future<void> updateRelationCid(
  //     String objectId, List<String> modelIdList, bool add);
  Future<void> updateUnset(String modelId, List<String> unsetFields);
}
