import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class EvolutionRepository {
  Future<List<EvolutionModel>> list(QueryBuilder<ParseObject> query,
      {Pagination? pagination});
  Future<String> update(EvolutionModel model);
  Future<EvolutionModel?> readById(String id);
  // Future<void> updateRelationCid(
  //     String objectId, List<String> modelIdList, bool add);
  Future<void> updateUnset(String modelId, List<String> unsetFields);
}
