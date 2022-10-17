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

  final healthPlanList = <HealthPlanModel>[].obs;

  final _healthPlan = Rxn<HealthPlanModel>();
  HealthPlanModel? get healthPlan => _healthPlan.value;
  set healthPlan(HealthPlanModel? healthPlanNew) => _healthPlan(healthPlanNew);

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

  @override
  void onInit() async {
    log('+++> Controller onInit');
    loaderListener(_loading);
    messageListener(_message);
    getHealthPlanTypeList();
    clientId = Get.arguments;
    super.onInit();
  }

  Future<void> getProfile() async {
    // _loading(true);
    if (clientId != null) {
      log('+++> getProfile $clientId', name: 'getProfile');
      ProfileModel? profileModelTemp =
          await _profileRepository.readById(clientId!);
      profile = profileModelTemp;
      onSetDateBirthday();
    }
    setFormFieldControllers();
    // _loading(false);
  }

  setFormFieldControllers() {
    nameTec.text = profile?.name ?? "";
    // phoneTec.text = profile?.phone ?? "";
    // cepTec.text = profile?.cep ?? "";
    // cpfTec.text = profile?.cpf ?? "";
    addressTec.text = profile?.address ?? "";
    pluscodeTec.text = profile?.pluscode ?? "";
    registerTec.text = profile?.register ?? "";
    descriptionTec.text = profile?.description ?? "";
    isFemale = profile?.isFemale ?? true;
    maskPhone = MaskTextInputFormatter(
        initialText: profile?.phone ?? "",
        mask: '(##) # ####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    phoneTec.text = maskPhone.getMaskedText();
    maskCPF = MaskTextInputFormatter(
        initialText: profile?.cpf ?? "",
        mask: '###.###.###-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    cpfTec.text = maskCPF.getMaskedText();
    maskCEP = MaskTextInputFormatter(
        initialText: profile?.cep ?? "",
        mask: '#####-###',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    cepTec.text = maskCEP.getMaskedText();
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
  void onSetDateDueHealthPlan() {
    dateDueHealthPlan = healthPlan?.due;
  }

  Future<void> healthPlanAdd() async {
    onSetDateDueHealthPlan();
    await Get.toNamed(Routes.clientProfileHealthPlan, arguments: null);
  }

  Future<void> healthPlanEdit(String healtPlanId) async {
    var healhPlanSelected =
        profile!.healthPlan!.firstWhere((element) => element.id == healtPlanId);
    healthPlan = healhPlanSelected;
    dateDueHealthPlan = healthPlan?.due;
    await Get.toNamed(Routes.clientProfileHealthPlan, arguments: healthPlan);
  }

  healthPlanUpdate({
    required HealthPlanTypeModel healthPlanType,
    required String code,
    required String description,
    required bool isDeleted,
  }) async {
    try {
      _loading(true);

      healthPlan = HealthPlanModel(
        id: healthPlan?.id,
        // profileId: profile?.id,
        profile: profile,
        healthPlanType: healthPlanType,
        code: code,
        due: dateDueHealthPlan,
        description: description,
        isDeleted: isDeleted,
      );
      log('${healthPlan!.id}', name: 'healthPlanUpdate');
      log('$isDeleted', name: 'healthPlanUpdate');
      String healthPlanId = await _healthPlanRepository.addEdit(healthPlan!);
      await _profileRepository.updateRelationHealthPlan(
          profile!.id!, [healthPlanId], !isDeleted);

      // final SplashController splashController = Get.find();
      // await splashController.updateUserProfile();
      await getProfile();
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

  Future<void> familyUpdate({
    required String id,
    required bool isAdd,
  }) async {
    try {
      _loading(true);

      await _profileRepository.updateRelationFamily(profile!.id!, [id], isAdd);
      await _profileRepository.updateRelationFamily(id, [profile!.id!], isAdd);

      // final SplashController splashController = Get.find();
      // await splashController.updateUserProfile();
      await getProfile();
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
}
