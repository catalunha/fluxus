import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EvolutionEntity {
  static const String className = 'Evolution';

  Future<EvolutionModel> fromParse(ParseObject parseObject) async {
    // //+++ get cid
    // List<CidModel> cidList = [];
    // QueryBuilder<ParseObject> queryCid =
    //     QueryBuilder<ParseObject>(ParseObject(CidEntity.className));
    // queryCid.whereRelatedTo('cid', 'Evolution', parseObject.objectId!);
    // final ParseResponse responseCid = await queryCid.query();
    // if (responseCid.success && responseCid.results != null) {
    //   for (var e in responseCid.results!) {
    //     cidList.add(CidEntity().fromParse(e as ParseObject));
    //   }
    // }
    // //--- get cid

    EvolutionModel model = EvolutionModel(
      id: parseObject.objectId!,
      start: parseObject.get('start'),
      event: parseObject.get('event'),
      professional: parseObject.get('professional') != null
          ? ProfileEntity().fromParseSimpleData(
              parseObject.get('professional') as ParseObject)
          : null,
      expertise: parseObject.get('expertise'),
      patient: parseObject.get('patient') != null
          ? ProfileEntity()
              .fromParseSimpleData(parseObject.get('patient') as ParseObject)
          : null,
      cid: parseObject.get<List<dynamic>>('cid') != null
          ? parseObject
              .get<List<dynamic>>('cid')!
              .map((e) => e.toString())
              .toList()
          : [],
      description: parseObject.get('description'),
      file: parseObject.get('file')?.get('url'),
      isDeleted: parseObject.get('isDeleted') ?? false,
    );
    return model;
  }

  Future<ParseObject> toParse(EvolutionModel model) async {
    final parseObject = ParseObject(EvolutionEntity.className);
    if (model.id != null) {
      parseObject.objectId = model.id;
    }
    if (model.start != null) {
      parseObject.set('start', model.start!.subtract(const Duration(hours: 3)));
    }
    if (model.event != null) {
      parseObject.set('event', model.event);
    }
    if (model.professional != null) {
      parseObject.set(
          'professional',
          (ParseObject(ProfileEntity.className)
                ..objectId = model.professional!.id)
              .toPointer());
    }
    if (model.expertise != null) {
      parseObject.set('expertise', model.expertise);
    }
    if (model.patient != null) {
      parseObject.set(
          'patient',
          (ParseObject(ProfileEntity.className)..objectId = model.patient!.id)
              .toPointer());
    }
    parseObject.set('cid', model.cid);

    if (model.description != null) {
      parseObject.set('description', model.description);
    }
    if (model.isDeleted != null) {
      parseObject.set('isDeleted', model.isDeleted);
    }
    return parseObject;
  }

  // ParseObject? toParseUpdateRelationCid({
  //   required String objectId,
  //   required List<String> modelIdList,
  //   required bool add,
  // }) {
  //   final parseObject = ParseObject(EvolutionEntity.className);
  //   parseObject.objectId = objectId;
  //   if (modelIdList.isEmpty) {
  //     parseObject.unset('cid');
  //     return parseObject;
  //   }
  //   if (add) {
  //     parseObject.addRelation(
  //       'cid',
  //       modelIdList
  //           .map(
  //             (element) => ParseObject(CidEntity.className)..objectId = element,
  //           )
  //           .toList(),
  //     );
  //   } else {
  //     parseObject.removeRelation(
  //         'cid',
  //         modelIdList
  //             .map((element) =>
  //                 ParseObject(CidEntity.className)..objectId = element)
  //             .toList());
  //   }
  //   return parseObject;
  // }
}
