import 'package:fluxus/app/core/models/procedure_model.dart';
import 'package:fluxus/app/data/b4a/entity/expertise_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ProcedureEntity {
  static const String className = 'Procedure';

  ProcedureModel fromParse(ParseObject parseObject) {
    // log('${parseObject.get('cost')}', name: 'ProcedureEntity.fromParse');
    ProcedureModel expertiseModel = ProcedureModel(
      id: parseObject.objectId!,
      expertise: parseObject.get('expertise') != null
          ? ExpertiseEntity()
              .fromParse(parseObject.get('expertise') as ParseObject)
          : null,
      name: parseObject.get('name'),
      code: parseObject.get('code'),
      cost: double.tryParse(parseObject.get<dynamic>('cost').toString()) ?? 0.0,
    );
    return expertiseModel;
  }
}
