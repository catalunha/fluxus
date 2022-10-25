import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/table/evaluation/evaluation_repository_exception.dart';
import 'package:fluxus/app/data/repositories/evaluation_repository.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class EvaluationAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final EvaluationRepository _evaluationRepository;
  EvaluationAddEditController({
    required EvaluationRepository evaluationRepository,
  }) : _evaluationRepository = evaluationRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _evaluation = Rxn<EvaluationModel>();
  EvaluationModel? get evaluation => _evaluation.value;
  set evaluation(EvaluationModel? evaluationModelNew) =>
      _evaluation(evaluationModelNew);

  var expertiseList = <ExpertiseModel>[].obs;
  final _expertiseModelSelected = Rxn<ExpertiseModel>();
  ExpertiseModel? get expertiseModelSelected => _expertiseModelSelected.value;
  set expertiseModelSelected(ExpertiseModel? newModel) =>
      _expertiseModelSelected(newModel);

  String? evaluationId;
  ProfileModel? _profileModel;
//+++ forms
  final nameTec = TextEditingController();
  final descriptionTec = TextEditingController();
  final _isPublic = false.obs;
  bool? get isPublic => _isPublic.value;
  set isPublic(bool? value) => _isPublic(value);
  final _isDeleted = false.obs;
  bool? get isDeleted => _isDeleted.value;
  set isDeleted(bool? value) => _isDeleted(value);
//--- forms

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    evaluationId = Get.arguments;
    var splashController = Get.find<SplashController>();
    _profileModel = splashController.userModel!.profile!;
    getEvaluation();

    super.onInit();
  }

  Future<void> getEvaluation() async {
    // _loading(true);
    expertiseList.clear();
    expertiseList.addAll(_profileModel!.expertise!);
    if (evaluationId != null) {
      EvaluationModel? evaluationModelTemp =
          await _evaluationRepository.readById(evaluationId!);
      evaluation = evaluationModelTemp;
      expertiseModelSelected = expertiseList
          .firstWhere((element) => element.id == evaluation!.expertiseId);
    } else {
      expertiseModelSelected = expertiseList[0];
    }
    setFormFieldControllers();
    // _loading(false);
  }

  setFormFieldControllers() {
    nameTec.text = evaluation?.name ?? "";
    descriptionTec.text = evaluation?.description ?? "";
    isPublic = evaluation?.isPublic;
  }

  Future<void> append({
    String? name,
    String? description,
    bool? isPublic,
    bool? isDeleted,
  }) async {
    try {
      _loading(true);
      if (evaluationId == null) {
        evaluation = EvaluationModel(
          professionalId: _profileModel!.id,
          expertiseId: expertiseModelSelected!.id,
          name: name,
          description: description,
          isPublic: isPublic,
          isDeleted: isDeleted,
        );
      } else {
        evaluation = evaluation!.copyWith(
          professionalId: evaluation!.professionalId,
          expertiseId: expertiseModelSelected!.id,
          name: name,
          description: description,
          isPublic: isPublic,
          isDeleted: isDeleted,
        );
      }
      evaluationId = await _evaluationRepository.update(evaluation!);

      evaluation = evaluation!.copyWith(id: evaluationId);
    } on EvaluationRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em EvaluationController',
        message: 'Não foi possivel salvar o evaluation',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
