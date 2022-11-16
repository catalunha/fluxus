import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/enums/event_status_enum.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/expect_model.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/table/expect/expect_repository_exception.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/expect_repository.dart';
import 'package:fluxus/app/data/repositories/expertise_repository.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class ExpectAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final ExpectRepository _expectRepository;
  final ProfileRepository _profileRepository;
  final EventStatusRepository _eventStatusRepository;
  final ExpertiseRepository _expertiseRepository;

  ExpectAddEditController({
    required ExpectRepository expectRepository,
    required ProfileRepository profileRepository,
    required EventStatusRepository eventStatusRepository,
    required ExpertiseRepository expertiseRepository,
  })  : _expectRepository = expectRepository,
        _profileRepository = profileRepository,
        _eventStatusRepository = eventStatusRepository,
        _expertiseRepository = expertiseRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _expect = Rxn<ExpectModel>();
  ExpectModel? get expect => _expect.value;
  set expect(ExpectModel? expectModelNew) => _expect(expectModelNew);

  final _patient = Rxn<ProfileModel>();
  ProfileModel? get patient => _patient.value;
  set patient(ProfileModel? patientNew) => _patient(patientNew);

  var healthPlanList = <HealthPlanModel>[].obs;

  // final _healthPlan = ''.obs;
  // String? get healthPlan => _healthPlan.value;
  // set healthPlan(String? value) => _healthPlan(value);

  var eventStatusList = <EventStatusModel>[].obs;
  final _eventStatusSelected = Rxn<EventStatusModel>();
  EventStatusModel? get eventStatusSelected => _eventStatusSelected.value;
  set eventStatusSelected(EventStatusModel? newModel) =>
      _eventStatusSelected(newModel);

  var expertiseList = <ExpertiseModel>[].obs;
  final _expertiseSelected = Rxn<ExpertiseModel>();
  ExpertiseModel? get expertiseSelected => _expertiseSelected.value;
  set expertiseSelected(ExpertiseModel? newModel) =>
      _expertiseSelected(newModel);

  String? expectId;

//+++ forms
  final descriptionTec = TextEditingController();
  final _isArchived = false.obs;
  bool? get isArchived => _isArchived.value;
  set isArchived(bool? value) => _isArchived(value);
  //--- forms
  @override
  void onReady() async {
    expectId = Get.arguments;
    await getExpect();
    getEventStatusList();
    getExpertiseList();
    super.onReady();
  }

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  getEventStatusList() async {
    List<EventStatusModel> all = await _eventStatusRepository.list();

    var eventStatusAutorized = [
      EventStatusEnum.emEspera.id,
      EventStatusEnum.emEsperaNormal.id,
      EventStatusEnum.emEsperaPrioridade.id,
    ];
    for (var eventStatus in all) {
      if (eventStatusAutorized.contains(eventStatus.id)) {
        eventStatusList.add(eventStatus);
      }
    }
    if (expectId == null) {
      eventStatusSelected = eventStatusList[0];
    } else {
      eventStatusSelected = expect!.eventStatus;
    }
  }

  getExpertiseList() async {
    List<ExpertiseModel> all = await _expertiseRepository.list();
    expertiseList(all);
    expertiseSelected = expertiseList[0];
    if (expectId == null) {
      expertiseSelected = expertiseList[0];
    } else {
      expertiseSelected = expect!.expertise;
    }
  }

  Future<void> getExpect() async {
    _loading(true);
    if (expectId != null) {
      ExpectModel? expectModelTemp =
          await _expectRepository.readById(expectId!);
      expect = expectModelTemp;
      patient = expect!.patient;
      healthPlanList.add(expect!.healthPlan!);
    }
    setFormFieldControllers();
    _loading(false);
  }

  setFormFieldControllers() {
    descriptionTec.text = expect?.description ?? "";
    isArchived = expect?.isArchived;
  }

  Future<void> append() async {
    try {
      _loading(true);

      if (expectId == null) {
        expect = ExpectModel(
          patient: patient,
          healthPlan: healthPlanList.first,
          description: descriptionTec.text,
          expertise: expertiseSelected,
          eventStatus: eventStatusSelected,
          isArchived: isArchived,
        );
      } else {
        expect = expect!.copyWith(
          patient: patient,
          healthPlan: healthPlanList.first,
          description: descriptionTec.text,
          expertise: expertiseSelected,
          eventStatus: eventStatusSelected,
          isArchived: isArchived,
        );
      }
      expectId = await _expectRepository.update(expect!);
    } on ExpectRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ExpectController',
        message: 'Não foi possivel gerar o pedido de espera',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  Future<void> setPatient({
    required String id,
  }) async {
    try {
      _loading(true);
      List<String> idsSplit = id.split(' ');
      if (idsSplit.length == 1) {
        ProfileModel? profileModelTemp = await _profileRepository
            .readById(id, includeColumns: ['name', 'healthPlan']);
        if (profileModelTemp != null) {
          _patient(profileModelTemp);
          healthPlanList.clear();
          healthPlanList.addAll([...profileModelTemp.healthPlan!]);
        }
      } else {
        _message.value = MessageModel(
          title: 'Erro em setPatient',
          message: 'É necessário buscar apenas o paciente',
          isError: true,
        );
      }
    } on ProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ExpectController',
        message: 'Não foi possivel buscar paciente',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  removeHealthPlan(String id) {
    healthPlanList.removeWhere((element) => element.id == id);
  }

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
//         title: 'Erro em ExpectAddEditController',
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
}
