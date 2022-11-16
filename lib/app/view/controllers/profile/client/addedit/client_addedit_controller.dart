import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/health_plan_type_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_exception.dart';
import 'package:fluxus/app/data/b4a/utils/xfile_to_parsefile.dart';
import 'package:fluxus/app/data/repositories/health_plan_repository.dart';
import 'package:fluxus/app/data/repositories/health_plan_type_repository.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClientAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final ProfileRepository _profileRepository;
  final HealthPlanRepository _healthPlanRepository;
  final HealthPlanTypeRepository _healthPlanTypeRepository;
  ClientAddEditController({
    required ProfileRepository profileRepository,
    required HealthPlanRepository healthPlanRepository,
    required HealthPlanTypeRepository healthPlanTypeRepository,
  })  : _profileRepository = profileRepository,
        _healthPlanRepository = healthPlanRepository,
        _healthPlanTypeRepository = healthPlanTypeRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _profile = Rxn<ProfileModel>();
  ProfileModel? get profile => _profile.value;
  set profile(ProfileModel? profileModelNew) => _profile(profileModelNew);

  // final healthPlanList = <HealthPlanModel>[].obs;

  // final _healthPlan = Rxn<HealthPlanModel>();
  // HealthPlanModel? get healthPlan => _healthPlan.value;
  // set healthPlan(HealthPlanModel? healthPlanNew) => _healthPlan(healthPlanNew);

  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  final Rxn<DateTime> _dateBirthday = Rxn<DateTime>();
  DateTime? get dateBirthday => _dateBirthday.value;
  set dateBirthday(DateTime? selectedDate1) {
    if (selectedDate1 != null) {
      _dateBirthday.value =
          DateTime(selectedDate1.year, selectedDate1.month, selectedDate1.day);
    }
  }

  final Rxn<DateTime> _dateDueHealthPlan = Rxn<DateTime>();
  DateTime? get dateDueHealthPlan => _dateDueHealthPlan.value;
  set dateDueHealthPlan(DateTime? selectedDateHealthPlanNew) {
    _dateDueHealthPlan(selectedDateHealthPlanNew);
  }

  var healthPlanTypeList = <HealthPlanTypeModel>[].obs;
  String? clientId;

//+++ forms
  final emailTec = TextEditingController();
  final nameTec = TextEditingController();
  final phoneTec = TextEditingController();
  final addressTec = TextEditingController();
  final cepTec = TextEditingController();
  final pluscodeTec = TextEditingController();
  final cpfTec = TextEditingController();
  final registerTec = TextEditingController();
  final descriptionTec = TextEditingController();
  final _isFemale = true.obs;
  bool get isFemale => _isFemale.value;
  set isFemale(bool temp) => _isFemale.value = temp;
  var maskPhone = MaskTextInputFormatter();
  var maskCPF = MaskTextInputFormatter();
  var maskCEP = MaskTextInputFormatter();
//--- forms

  List<ProfileModel> profileList = <ProfileModel>[].obs;
  List<ProfileModel> profileListOriginal = <ProfileModel>[];
  List<HealthPlanModel> healthPlanList = <HealthPlanModel>[].obs;
  List<HealthPlanModel> healthPlanListOriginal = <HealthPlanModel>[];
  @override
  void onReady() {
    clientId = Get.arguments;
    getProfile();
    super.onReady();
  }

  @override
  void onInit() async {
    log('+++> Controller onInit');
    loaderListener(_loading);
    messageListener(_message);
    getHealthPlanTypeList();
    super.onInit();
  }

  Future<void> getProfile() async {
    _loading(true);
    if (clientId != null) {
      log('+++> getProfile $clientId', name: 'getProfile');
      ProfileModel? profileModelTemp =
          await _profileRepository.readById(clientId!);
      profile = profileModelTemp;
      if (profileModelTemp?.family != null) {
        profileList.addAll([...profileModelTemp!.family!]);
        profileListOriginal.addAll([...profileModelTemp.family!]);
        healthPlanList.addAll([...profileModelTemp.healthPlan!]);
        healthPlanListOriginal.addAll([...profileModelTemp.healthPlan!]);
      }
      onSetDateBirthday();
    } else {
      healthPlanList.add(
        HealthPlanModel(
          healthPlanType:
              HealthPlanTypeModel(id: 'fp5YkDWvxq', name: 'Particular'),
          code: '0',
          description: 'Plano particular padrão fluxus',
        ),
      );
    }
    setFormFieldControllers();
    _loading(false);
  }

  setFormFieldControllers() {
    nameTec.text = profile?.name ?? "";
    emailTec.text = profile?.email ?? "";
    phoneTec.text = profile?.phone ?? "";
    cepTec.text = profile?.cep ?? "";
    cpfTec.text = profile?.cpf ?? "";
    addressTec.text = profile?.address ?? "";
    pluscodeTec.text = profile?.pluscode ?? "";
    registerTec.text = profile?.register ?? "";
    descriptionTec.text = profile?.description ?? "";
    isFemale = profile?.isFemale ?? true;
    // maskPhone = MaskTextInputFormatter(
    //     initialText: profile?.phone ?? "",
    //     mask: '(##) # ####-####',
    //     filter: {"#": RegExp(r'[0-9]')},
    //     type: MaskAutoCompletionType.lazy);
    // phoneTec.text = maskPhone.getMaskedText();
    // maskCPF = MaskTextInputFormatter(
    //     initialText: profile?.cpf ?? "",
    //     mask: '###.###.###-##',
    //     filter: {"#": RegExp(r'[0-9]')},
    //     type: MaskAutoCompletionType.lazy);
    // cpfTec.text = maskCPF.getMaskedText();
    // maskCEP = MaskTextInputFormatter(
    //     initialText: profile?.cep ?? "",
    //     mask: '#####-###',
    //     filter: {"#": RegExp(r'[0-9]')},
    //     type: MaskAutoCompletionType.lazy);
    // cepTec.text = maskCEP.getMaskedText();
  }

  getHealthPlanTypeList() async {
    List<HealthPlanTypeModel> all = await _healthPlanTypeRepository.list();
    healthPlanTypeList(all);
  }

  void onSetDateBirthday() {
    dateBirthday = profile?.birthday;
  }

  Future<void> append({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? cep,
    String? pluscode,
    String? cpf,
    bool? isFemale,
    DateTime? birthday,
    String? register,
    String? description,
  }) async {
    try {
      _loading(true);
      if (clientId == null) {
        profile = ProfileModel(
          name: name,
          email: email,
          phone: phone,
          address: address,
          cep: cep,
          pluscode: pluscode,
          cpf: cpf,
          isFemale: isFemale,
          register: register,
          description: description,
          birthday: dateBirthday,
        );
      } else {
        profile = profile!.copyWith(
          name: name,
          email: email,
          phone: phone,
          address: address,
          cep: cep,
          pluscode: pluscode,
          cpf: cpf,
          isFemale: isFemale,
          register: register,
          description: description,
          birthday: dateBirthday,
        );
      }
      String userProfileId = await _profileRepository.update(profile!);
      await updateFamilyInProfile(userProfileId);
      await updateHealthPlanInProfile(userProfileId);
      if (clientId == null) {
        await _profileRepository.updateRelationOffice(
            userProfileId, ['RrrMr52QBM'], true);
      }
      profile = profile!.copyWith(id: userProfileId);
      clientId = userProfileId;
      if (_xfile != null) {
        String? photoUrl = await XFileToParseFile.xFileToParseFile(
          xfile: _xfile!,
          className: ProfileEntity.className,
          objectId: userProfileId,
          objectAttribute: 'photo',
        );
        profile = profile!.copyWith(photo: photoUrl);
      }

      // final SplashController splashController = Get.find();
      // await splashController.updateUserProfile();
      // await getProfile();
    } on ProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ProfileController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

// health Plan
  // void onSetDateDueHealthPlan() {
  //   dateDueHealthPlan = healthPlan?.due;
  // }

  Future<void> healthPlanPageAdd() async {
    // onSetDateDueHealthPlan();
    // var healthPlan = HealthPlanModel();
    dateDueHealthPlan = null;
    await Get.toNamed(Routes.clientProfileHealthPlan, arguments: null);
  }

  Future<void> healthPlanPageEdit(String healtPlanId) async {
    var healthPlan =
        healthPlanList.firstWhereOrNull((element) => element.id == healtPlanId);
    dateDueHealthPlan = healthPlan?.due;
    await Get.toNamed(Routes.clientProfileHealthPlan, arguments: healthPlan);
  }

  addHealthPlan({
    required HealthPlanModel healthPlanTemp,
    // required String? id,
    // required HealthPlanTypeModel healthPlanType,
    // required String code,
    // required String description,
    // required bool isDeleted,
  }) async {
    // try {
    // _loading(true);
    // HealthPlanModel healthPlanTemp;
    if (healthPlanTemp.id != null) {
      //   healthPlanList.add(healthPlanTemp);
      // } else {
      // var healthPlanTemp2 = healthPlanList
      //     .firstWhereOrNull((element) => element.id == healthPlanTemp.id);
      // healthPlanTemp = healthPlanTemp2!.copyWith(
      //   healthPlanType: healthPlanTemp.healthPlanType,
      //   code: healthPlanTemp.code,
      //   due: dateDueHealthPlan,
      //   description: healthPlanTemp.description,
      // );
      _loading(true);
      await _healthPlanRepository.addEdit(healthPlanTemp);
      healthPlanList.removeWhere((element) => element.id == healthPlanTemp.id);
      // healthPlanList.add(healthPlanTemp);
      _loading(false);
    }
    healthPlanList.add(healthPlanTemp);

    // log('${healthPlan!.id}', name: 'healthPlanUpdate');
    // log('$isDeleted', name: 'healthPlanUpdate');
    // String healthPlanId = await _healthPlanRepository.addEdit(healthPlan!);
    // await _profileRepository.updateRelationHealthPlan(
    //     profile!.id!, [healthPlanId], !isDeleted);

    // final SplashController splashController = Get.find();
    // await splashController.updateUserProfile();
    // await getProfile();
    // } on ProfileRepositoryException {
    //   _message.value = MessageModel(
    //     title: 'Erro em ProfileController',
    //     message: 'Não foi possivel salvar o perfil',
    //     isError: true,
    //   );
    // } finally {
    //   // _loading(false);
    // }
  }

  removeHealthPlan(String healthPlanId) {
    healthPlanList.removeWhere((element) => element.id == healthPlanId);
  }

  Future<void> updateHealthPlanInProfile(String profileId) async {
    List<HealthPlanModel> healthPlanListResult = <HealthPlanModel>[];
    healthPlanListResult.addAll([...healthPlanList]);
    for (var healthPlanOriginal in healthPlanListOriginal) {
      var healthPlanFound = healthPlanList
          .firstWhereOrNull((element) => element.id == healthPlanOriginal.id);
      if (healthPlanFound == null) {
        await _profileRepository.updateRelationHealthPlan(
            profileId, [healthPlanOriginal.id!], false);
      } else {
        healthPlanListResult
            .removeWhere((element) => element.id == healthPlanFound.id);
      }
    }
    for (var healthPlanResult in healthPlanListResult) {
      String healthPlanId =
          await _healthPlanRepository.addEdit(healthPlanResult);
      await _profileRepository.updateRelationHealthPlan(
          profileId, [healthPlanId], true);
    }
  }

  Future<void> addFamily(String profileId) async {
    try {
      _loading(true);
      var profiletemp = await _profileRepository.readById(profileId);
      if (profiletemp != null) {
        profileList.add(profiletemp);
      }
    } on ProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em EventController',
        message: 'Não foi possivel salvar o atendimento',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  removeFamily(String profileId) {
    profileList.removeWhere((element) => element.id == profileId);
  }

  Future<void> updateFamilyInProfile(String profileIdActual) async {
    List<ProfileModel> profileListResult = <ProfileModel>[];
    profileListResult.addAll([...profileList]);
    for (var profileOriginal in profileListOriginal) {
      var profileFound = profileList
          .firstWhereOrNull((element) => element.id == profileOriginal.id);
      if (profileFound == null) {
        await _profileRepository.updateRelationFamily(
            profileIdActual, [profileOriginal.id!], false);
        await _profileRepository.updateRelationFamily(
            profileOriginal.id!, [profileIdActual], false);
      } else {
        profileListResult
            .removeWhere((element) => element.id == profileFound.id);
      }
    }
    for (var profileResult in profileListResult) {
      await _profileRepository.updateRelationFamily(
          profileIdActual, [profileResult.id!], true);
      await _profileRepository.updateRelationFamily(
          profileResult.id!, [profileIdActual], true);
    }
  }
}
