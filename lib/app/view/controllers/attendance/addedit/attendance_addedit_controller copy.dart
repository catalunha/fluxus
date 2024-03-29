// import 'package:flutter/widgets.dart';
// import 'package:fluxus/app/core/models/attendance_model.dart';
// import 'package:fluxus/app/core/models/event_status_model.dart';
// import 'package:fluxus/app/core/models/evolution_model.dart';
// import 'package:fluxus/app/core/models/health_plan_model.dart';
// import 'package:fluxus/app/core/models/procedure_model.dart';
// import 'package:fluxus/app/core/models/profile_model.dart';
// import 'package:fluxus/app/data/b4a/table/attendance/attendance_repository_exception.dart';
// import 'package:fluxus/app/data/b4a/table/profile/profile_repository_exception.dart';
// import 'package:fluxus/app/data/repositories/attendance_repository.dart';
// import 'package:fluxus/app/data/repositories/evolution_repository.dart';
// import 'package:fluxus/app/data/repositories/profile_repository.dart';
// import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
// import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
// import 'package:get/get.dart';

// class AttendanceAddEditController extends GetxController
//     with LoaderMixin, MessageMixin {
//   final AttendanceRepository _attendanceRepository;
//   final ProfileRepository _profileRepository;
//   final EvolutionRepository _evolutionRepository;

//   AttendanceAddEditController({
//     required AttendanceRepository attendanceRepository,
//     required ProfileRepository profileRepository,
//     required EvolutionRepository evolutionRepository,
//   })  : _attendanceRepository = attendanceRepository,
//         _profileRepository = profileRepository,
//         _evolutionRepository = evolutionRepository;

//   final _loading = false.obs;
//   final _message = Rxn<MessageModel>();

//   final Rxn<DateTime> _dAutorization = Rxn<DateTime>();
//   DateTime? get dAutorization => _dAutorization.value;
//   set dAutorization(DateTime? newDate) {
//     _dAutorization(newDate);
//   }

//   final _professional = Rxn<ProfileModel>();
//   ProfileModel? get professional => _professional.value;
//   set professional(ProfileModel? professionalNew) =>
//       _professional(professionalNew);

//   var procedureList = <ProcedureModel>[].obs;

//   final _patient = Rxn<ProfileModel>();
//   ProfileModel? get patient => _patient.value;
//   set patient(ProfileModel? patientNew) => _patient(patientNew);

//   var healthPlanList = <HealthPlanModel>[].obs;

//   final _healthPlan = ''.obs;
//   String? get healthPlan => _healthPlan.value;
//   set healthPlan(String? value) => _healthPlan(value);

// //+++ forms
//   final autorizationTec = TextEditingController();
// //--- forms

//   @override
//   void onInit() async {
//     loaderListener(_loading);
//     messageListener(_message);
//     _dAutorization(DateTime.now());
//     super.onInit();
//   }

//   setFormFieldControllers() {
//     autorizationTec.text = "";
//   }

//   Future<void> append({
//     String? autorization,
//   }) async {
//     try {
//       _loading(true);
//       for (var procedure in procedureList) {
//         var evolutionModel = EvolutionModel(
//           professional: professional,
//           procedure: procedure,
//           expertise: procedure.expertise!.id,
//           patient: patient,
//         );
//         String evolutionId = await _evolutionRepository.update(evolutionModel);
//         var attendance = AttendanceModel(
//           professional: professional,
//           procedure: procedure,
//           patient: patient,
//           healthPlan: HealthPlanModel(id: healthPlan),
//           autorization: autorization!.isEmpty ? null : autorization,
//           dAutorization: dAutorization,
//           eventStatus: EventStatusModel(id: 'zoFBVNZ16I'),
//           evolution: evolutionId,
//         );
//         await _attendanceRepository.update(attendance);
//       }
//     } on AttendanceRepositoryException {
//       _message.value = MessageModel(
//         title: 'Erro em AttendanceController',
//         message: 'Não foi possivel gerar o atendimento',
//         isError: true,
//       );
//     } finally {
//       _loading(false);
//     }
//   }

//   Future<void> setProfissional({
//     required String id,
//   }) async {
//     try {
//       _loading(true);
//       List<String> idsSplit = id.split(' ');
//       if (idsSplit.length == 1) {
//         ProfileModel? profileModelTemp = await _profileRepository
//             .readById(id, includeColumns: ['name', 'procedure']);
//         if (profileModelTemp != null) {
//           _professional(profileModelTemp);
//           procedureList.clear();
//           procedureList.addAll([...profileModelTemp.procedure!]);
//         }
//       } else {
//         _message.value = MessageModel(
//           title: 'Erro em setProfissional',
//           message: 'É necessário buscar apenas o profissional',
//           isError: true,
//         );
//       }
//     } on ProfileRepositoryException {
//       _message.value = MessageModel(
//         title: 'Erro em AttendanceController',
//         message: 'Não foi possivel buscar profissional',
//         isError: true,
//       );
//     } finally {
//       _loading(false);
//     }
//   }

//   removeProcedure(String id) {
//     procedureList.removeWhere((element) => element.id == id);
//   }

//   addProcedure(ProcedureModel procedureModel) {
//     procedureList.add(procedureModel);
//   }
//   // setProcedure({
//   //   required String ids,
//   //   required bool add,
//   // }) {
//   //   List<String> idsSplit = ids.split(' ');
//   //   String idProfessional = idsSplit[0];
//   //   String idProcedure = idsSplit[1];

//   //   if (professional!.id == idProfessional) {
//   //     if (add) {
//   //       procedureList.add(idProcedure);
//   //     } else {
//   //       procedureList.remove(idProcedure);
//   //     }
//   //   } else {
//   //     _message.value = MessageModel(
//   //       title: 'Profissional diferente',
//   //       message: 'Use procedimentos do mesmo profissional',
//   //       isError: true,
//   //     );
//   //   }
//   // }

//   // String getProcedure(String procedureId, String getFieldName) {
//   //   if (patient != null) {
//   //     var proceduresThisProfessional = professional!.procedure!
//   //         .firstWhereOrNull((element) => element.id == procedureId);
//   //     if (proceduresThisProfessional != null) {
//   //       if (getFieldName == 'code') {
//   //         return proceduresThisProfessional.code ?? '...';
//   //       } else if (getFieldName == 'name') {
//   //         return proceduresThisProfessional.name ?? '...';
//   //       } else {
//   //         return proceduresThisProfessional.id ?? '...';
//   //       }
//   //     }
//   //     return '...';
//   //   } else {
//   //     return 'Procedimento não encontrado';
//   //   }
//   // }

//   Future<void> setPatient({
//     required String id,
//   }) async {
//     try {
//       _loading(true);
//       List<String> idsSplit = id.split(' ');
//       if (idsSplit.length == 1) {
//         ProfileModel? profileModelTemp = await _profileRepository
//             .readById(id, includeColumns: ['name', 'healthPlan']);
//         if (profileModelTemp != null) {
//           _patient(profileModelTemp);
//           healthPlanList.clear();
//           healthPlanList.addAll([...profileModelTemp.healthPlan!]);
//         }
//       } else {
//         _message.value = MessageModel(
//           title: 'Erro em setProfissional',
//           message: 'É necessário buscar apenas o profissional',
//           isError: true,
//         );
//       }
//     } on ProfileRepositoryException {
//       _message.value = MessageModel(
//         title: 'Erro em AttendanceController',
//         message: 'Não foi possivel buscar profissional',
//         isError: true,
//       );
//     } finally {
//       _loading(false);
//     }
//   }

//   removePatient(String id) {
//     procedureList.removeWhere((element) => element.id == id);
//   }

//   addPatient(ProcedureModel procedureModel) {
//     procedureList.add(procedureModel);
//   }

// //
// //
// //
//   Future<void> setPatientHealthPlan({
//     required String ids,
//   }) async {
//     try {
//       _loading(true);

//       List<String> idsSplit = ids.split(' ');
//       if (idsSplit.length == 2) {
//         String idPatient = idsSplit[0];
//         healthPlan = idsSplit[1];

//         ProfileModel? profileModelTemp = await _profileRepository
//             .readById(idPatient, includeColumns: ['name', 'healthPlan']);
//         _patient(profileModelTemp);
//       } else {
//         _message.value = MessageModel(
//           title: 'Erro em setPatientHealthPlan',
//           message: 'É necessário buscar o paciente e seu convênio',
//           isError: true,
//         );
//       }
//     } on ProfileRepositoryException {
//       _message.value = MessageModel(
//         title: 'Erro em AttendanceAddEditController',
//         message: 'Não foi possivel buscar paciente',
//         isError: true,
//       );
//     } finally {
//       _loading(false);
//     }
//   }

//   String getHealthPlan(String getFieldName) {
//     if (patient != null) {
//       var healthPlanThisPatient = patient!.healthPlan!
//           .firstWhereOrNull((element) => element.id == healthPlan);
//       if (healthPlanThisPatient != null) {
//         if (getFieldName == 'code') {
//           return healthPlanThisPatient.code ?? '...';
//         } else if (getFieldName == 'name') {
//           return healthPlanThisPatient.healthPlanType?.name ?? '...';
//         } else {
//           return healthPlanThisPatient.healthPlanType?.id ?? '...';
//         }
//       }
//       return '...';
//     } else {
//       return 'Convênio não encontrado';
//     }
//   }
// }
