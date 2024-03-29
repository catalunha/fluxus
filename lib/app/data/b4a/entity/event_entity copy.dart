// import 'dart:developer';

// import 'package:fluxus/app/core/models/event_model.dart';
// import 'package:fluxus/app/core/models/profile_model.dart';
// import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
// import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
// import 'package:fluxus/app/data/b4a/entity/room_entity.dart';
// import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// class EventEntity {
//   static const String className = 'Event';

//   Future<EventModel> fromParse(ParseObject parseObject) async {
//     //+++ get professionals
//     List<ProfileModel> professionalsList = [];
//     QueryBuilder<ParseObject> queryProfessionals =
//         QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
//     queryProfessionals.whereRelatedTo(
//         'professionals', 'Event', parseObject.objectId!);
//     final ParseResponse responseProfessionals =
//         await queryProfessionals.query();
//     if (responseProfessionals.success &&
//         responseProfessionals.results != null) {
//       for (var e in responseProfessionals.results!) {
//         professionalsList
//             .add(await ProfileEntity().fromParse(e as ParseObject));
//       }
//     }
//     //--- get professionals

//     //+++ get expertises
//     Map<String, String>? procedures = <String, String>{};
//     Map<String, dynamic>? tempClass =
//         parseObject.get<Map<String, dynamic>>('procedures');
//     if (tempClass != null) {
//       for (var item in tempClass.entries) {
//         procedures[item.key] = item.value;
//       }
//     }
//     //--- get expertises

//     //+++ get patients
//     List<ProfileModel> patientsList = [];
//     QueryBuilder<ParseObject> queryPatients =
//         QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
//     queryPatients.whereRelatedTo('patients', 'Event', parseObject.objectId!);
//     final ParseResponse responsePatients = await queryPatients.query();
//     if (responsePatients.success && responsePatients.results != null) {
//       for (var e in responsePatients.results!) {
//         patientsList.add(await ProfileEntity().fromParse(e as ParseObject));
//       }
//     }
//     // --- get patients
//     //+++ get healthPlans
//     Map<String, String>? healthPlans = <String, String>{};
//     Map<String, dynamic>? tempClass2 =
//         parseObject.get<Map<String, dynamic>>('healthPlans');
//     if (tempClass2 != null) {
//       for (var item in tempClass2.entries) {
//         healthPlans[item.key] = item.value;
//       }
//     }
//     // --- get healthPlans
//     // log('${parseObject.get('room')}', name: 'EventEntity');
//     // log('${RoomEntity().fromParse(parseObject.get('room') as ParseObject)}',
//     // name: 'EventEntity')
//     // log('${parseObject.get('start')}', name: 'EventEntity.fromParse');
//     EventModel model = EventModel(
//       id: parseObject.objectId!,
//       professionals: professionalsList,
//       procedures: procedures,
//       patients: patientsList,
//       healthPlans: healthPlans,
//       autorization: parseObject.get('autorization'),
//       fatura: parseObject.get('fatura'),
//       room: parseObject.get('room') != null
//           ? RoomEntity().fromParse(parseObject.get('room') as ParseObject)
//           : null,
//       status: parseObject.get('status') != null
//           ? EventStatusEntity()
//               .fromParse(parseObject.get('status') as ParseObject)
//           : null,
//       start: parseObject.get<DateTime>('start')?.toLocal(),
//       end: parseObject.get<DateTime>('end')?.toLocal(),
//       // start: parseObject
//       //     .get<DateTime>('start')!
//       //     .subtract(const Duration(hours: 3)),
//       // end: parseObject.get<DateTime>('end')!.subtract(const Duration(hours: 3)),
//       log: parseObject.get('log'),
//       description: parseObject.get('description'),
//       isDeleted: parseObject.get('isDeleted') ?? false,
//     );
//     return model;
//   }

//   EventModel fromParseSimpleData(ParseObject parseObject) {
//     // //+++ get professionals
//     // List<ProfileModel> professionalsList = [];
//     // QueryBuilder<ParseObject> queryProfessionals =
//     //     QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
//     // queryProfessionals.whereRelatedTo(
//     //     'professionals', 'Event', parseObject.objectId!);
//     // final ParseResponse responseProfessionals =
//     //     await queryProfessionals.query();
//     // if (responseProfessionals.success &&
//     //     responseProfessionals.results != null) {
//     //   for (var e in responseProfessionals.results!) {
//     //     professionalsList
//     //         .add(await ProfileEntity().fromParse(e as ParseObject));
//     //   }
//     // }
//     // //--- get professionals

//     // //+++ get expertises
//     // Map<String, String>? expertises = <String, String>{};
//     // Map<String, dynamic>? tempClass =
//     //     parseObject.get<Map<String, dynamic>>('expertises');
//     // if (tempClass != null) {
//     //   for (var item in tempClass.entries) {
//     //     expertises[item.key] = item.value;
//     //   }
//     // }
//     // //--- get expertises

//     // //+++ get patients
//     // List<ProfileModel> patientsList = [];
//     // QueryBuilder<ParseObject> queryPatients =
//     //     QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
//     // queryPatients.whereRelatedTo('patients', 'Event', parseObject.objectId!);
//     // final ParseResponse responsePatients = await queryPatients.query();
//     // if (responsePatients.success && responsePatients.results != null) {
//     //   for (var e in responsePatients.results!) {
//     //     patientsList.add(await ProfileEntity().fromParse(e as ParseObject));
//     //   }
//     // }
//     // // --- get patients
//     // //+++ get healthPlans
//     // Map<String, String>? healthPlans = <String, String>{};
//     // Map<String, dynamic>? tempClass2 =
//     //     parseObject.get<Map<String, dynamic>>('healthPlans');
//     // if (tempClass2 != null) {
//     //   for (var item in tempClass2.entries) {
//     //     healthPlans[item.key] = item.value;
//     //   }
//     // }
//     // // --- get healthPlans
//     EventModel model = EventModel(
//       id: parseObject.objectId!,
//       // professionals: professionalsList,
//       // expertises: expertises,
//       // patients: patientsList,
//       // healthPlans: healthPlans,
//       autorization: parseObject.get('autorization'),
//       fatura: parseObject.get('fatura'),
//       room: parseObject.get('room') != null
//           ? RoomEntity().fromParse(parseObject.get('room') as ParseObject)
//           : null,
//       status: parseObject.get('status') != null
//           ? EventStatusEntity()
//               .fromParse(parseObject.get('status') as ParseObject)
//           : null,
//       // parseObject.set('start', model.start!.subtract(const Duration(hours: 3)));

//       start: parseObject.get<DateTime>('start')?.toLocal(),
//       end: parseObject.get<DateTime>('end')?.toLocal(),
//       // start: parseObject
//       //     .get<DateTime>('start')!
//       //     .subtract(const Duration(hours: 3)),
//       // end: parseObject.get<DateTime>('end')!.subtract(const Duration(hours: 3)),
//       log: parseObject.get('log'),
//       description: parseObject.get('description'),
//       isDeleted: parseObject.get('isDeleted') ?? false,
//     );
//     return model;
//   }

//   Future<ParseObject> toParse(EventModel model) async {
//     final parseObject = ParseObject(EventEntity.className);
//     if (model.id != null) {
//       parseObject.objectId = model.id;
//     }
//     if (model.procedures != null) {
//       // profileParseObject.set<Map<String, dynamic>>('expertises', model.expertises!);
//       var data = <String, dynamic>{};
//       for (var item in model.procedures!.entries) {
//         data[item.key] = item.value;
//       }
//       parseObject.set('procedures', data);
//     }
//     if (model.healthPlans != null) {
//       // profileParseObject.set<Map<String, dynamic>>('healthPlans', model.healthPlans!);
//       var data = <String, dynamic>{};
//       for (var item in model.healthPlans!.entries) {
//         data[item.key] = item.value;
//       }
//       parseObject.set('healthPlans', data);
//     }
//     if (model.autorization != null) {
//       parseObject.set('autorization', model.autorization);
//     }
//     if (model.fatura != null) {
//       parseObject.set('fatura', model.fatura);
//     }
//     if (model.room != null) {
//       parseObject.set(
//           'room',
//           (ParseObject(RoomEntity.className)..objectId = model.room!.id)
//               .toPointer());
//     }
//     if (model.start != null) {
//       log('${model.start}', name: 'EventEntity.toParse');
//       parseObject.set('start', model.start);
//       // parseObject.set('start', model.start!.subtract(const Duration(hours: 3)));
//     }
//     if (model.end != null) {
//       parseObject.set('end', model.end);
//       // parseObject.set('end', model.end!.subtract(const Duration(hours: 3)));
//     }
//     if (model.status != null) {
//       parseObject.set(
//           'status',
//           (ParseObject(EventStatusEntity.className)
//                 ..objectId = model.status!.id)
//               .toPointer());
//     }
//     if (model.log != null) {
//       parseObject.set('log', model.log);
//     }
//     if (model.description != null) {
//       parseObject.set('description', model.description);
//     }
//     if (model.isDeleted != null) {
//       parseObject.set('isDeleted', model.isDeleted);
//     }
//     return parseObject;
//   }

//   ParseObject? toParseUpdateRelationProfessionals({
//     required String objectId,
//     required List<String> modelIdList,
//     required bool add,
//   }) {
//     final parseObject = ParseObject(EventEntity.className);
//     parseObject.objectId = objectId;
//     if (modelIdList.isEmpty) {
//       parseObject.unset('professionals');
//       return parseObject;
//     }
//     if (add) {
//       parseObject.addRelation(
//         'professionals',
//         modelIdList
//             .map(
//               (element) =>
//                   ParseObject(ProfileEntity.className)..objectId = element,
//             )
//             .toList(),
//       );
//     } else {
//       parseObject.removeRelation(
//           'professionals',
//           modelIdList
//               .map((element) =>
//                   ParseObject(ProfileEntity.className)..objectId = element)
//               .toList());
//     }
//     return parseObject;
//   }

//   ParseObject? toParseUpdateRelationPatients({
//     required String objectId,
//     required List<String> modelIdList,
//     required bool add,
//   }) {
//     final parseObject = ParseObject(EventEntity.className);
//     parseObject.objectId = objectId;
//     if (modelIdList.isEmpty) {
//       parseObject.unset('patients');
//       return parseObject;
//     }
//     if (add) {
//       parseObject.addRelation(
//         'patients',
//         modelIdList
//             .map(
//               (element) =>
//                   ParseObject(ProfileEntity.className)..objectId = element,
//             )
//             .toList(),
//       );
//     } else {
//       parseObject.removeRelation(
//         'patients',
//         modelIdList
//             .map((element) =>
//                 ParseObject(ProfileEntity.className)..objectId = element)
//             .toList(),
//       );
//     }
//     return parseObject;
//   }
// }
