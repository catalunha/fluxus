import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/b4a/entity/evaluation_entity.dart';
import 'package:fluxus/app/data/b4a/table/evolution/evolution_repository_exception.dart';
import 'package:fluxus/app/data/repositories/evaluation_repository.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EvolutionAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final EvolutionRepository _evolutionRepository;
  final EvaluationRepository _evaluationRepository;

  EvolutionAddEditController({
    required EvolutionRepository evolutionRepository,
    required EvaluationRepository evaluationRepository,
  })  : _evolutionRepository = evolutionRepository,
        _evaluationRepository = evaluationRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _evolution = Rxn<EvolutionModel>();
  EvolutionModel? get evolution => _evolution.value;
  set evolution(EvolutionModel? evolutionModelNew) =>
      _evolution(evolutionModelNew);

  String? evolutionId;
//+++ forms
  final descriptionTec = TextEditingController();
  final _isArchived = false.obs;
  bool? get isArchived => _isArchived.value;
  set isArchived(bool? value) => _isArchived(value);
//--- forms

  List<EvaluationModel> evaluationList = <EvaluationModel>[].obs;
  final _evaluationSelected = Rxn<EvaluationModel>();
  EvaluationModel? get evaluationSelected => _evaluationSelected.value;
  set evaluationSelected(EvaluationModel? newModel) =>
      _evaluationSelected(newModel);

  @override
  void onInit() async {
    print('EvolutionAddEditController');
    loaderListener(_loading);
    messageListener(_message);
    evolutionId = Get.arguments;
    getEvolution();
    getEvaluation();
    super.onInit();
  }

  Future<void> getEvolution() async {
    // _loading(true);
    if (evolutionId != null) {
      EvolutionModel? evolutionModelTemp =
          await _evolutionRepository.readById(evolutionId!);
      evolution = evolutionModelTemp;
    }
    setFormFieldControllers();
    // _loading(false);
  }

  setFormFieldControllers() {
    descriptionTec.text = evolution?.description ?? "";
    isArchived = evolution?.isArchived;
  }

  Future<void> append({
    String? description,
    bool? isArchived,
  }) async {
    try {
      _loading(true);
      if (evolutionId == null) {
        evolution = EvolutionModel(
          description: description,
          isArchived: isArchived,
        );
      } else {
        evolution = evolution!.copyWith(
          description: description,
          isArchived: isArchived,
        );
      }
      evolutionId = await _evolutionRepository.update(evolution!);

      evolution = evolution!.copyWith(id: evolutionId);
    } on EvolutionRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em EvolutionController',
        message: 'Não foi possivel salvar o evolution',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  void getEvaluation() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(EvaluationEntity.className));
    List<EvaluationModel> temp = await _evaluationRepository.list(
        query,
        Pagination()
          ..limit = 20
          ..page = 1);

    evaluationList.addAll(temp);
  }
}
