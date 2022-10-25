import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/b4a/table/evolution/evolution_repository_exception.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class EvolutionAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final EvolutionRepository _evolutionRepository;
  EvolutionAddEditController({
    required EvolutionRepository evolutionRepository,
  }) : _evolutionRepository = evolutionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _evolution = Rxn<EvolutionModel>();
  EvolutionModel? get evolution => _evolution.value;
  set evolution(EvolutionModel? evolutionModelNew) =>
      _evolution(evolutionModelNew);

  String? evolutionId;
//+++ forms
  final descriptionTec = TextEditingController();
//--- forms

  @override
  void onInit() async {
    print('EvolutionAddEditController');
    loaderListener(_loading);
    messageListener(_message);
    evolutionId = Get.arguments;
    getEvolution();
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
  }

  Future<void> append({
    String? description,
  }) async {
    try {
      _loading(true);
      if (evolutionId == null) {
        evolution = EvolutionModel(
          description: description,
        );
      } else {
        evolution = evolution!.copyWith(
          description: description,
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
}
