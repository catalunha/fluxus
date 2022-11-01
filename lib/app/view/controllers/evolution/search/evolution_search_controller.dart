import 'dart:developer';

import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class EvolutionSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final EvolutionRepository _evolutionRepository;
  EvolutionSearchController({
    required EvolutionRepository evolutionRepository,
  }) : _evolutionRepository = evolutionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  var evolutionList = <EvolutionModel>[].obs;

  String? eventId;
  @override
  void onReady() {
    listAll();
    super.onReady();
  }

  @override
  void onInit() {
    evolutionList.clear();
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> listAll() async {
    _loading(true);
    log('+++', name: 'EvolutionSearchController.listAll');
    var splashController = Get.find<SplashController>();
    String professionalId = splashController.userModel!.profile!.id!;
    List<EvolutionModel> temp = await _evolutionRepository.list(professionalId);

    evolutionList.addAll(temp);
    _loading(false);
  }
}
