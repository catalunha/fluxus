import 'dart:developer';

import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/b4a/entity/evolution_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EvolutionHistoryController extends GetxController
    with LoaderMixin, MessageMixin {
  final EvolutionRepository _evolutionRepository;
  EvolutionHistoryController({
    required EvolutionRepository evolutionRepository,
  }) : _evolutionRepository = evolutionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  var evolutionHistory = <EvolutionModel>[].obs;

  String? patientId;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EvolutionEntity.className));

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    evolutionHistory.clear();
    _changePagination(1, 12);
    ever(_pagination, (_) async => await listAll());
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    patientId = Get.arguments;
    await searchHistoryThisPatient();
    super.onReady();
  }

  void _changePagination(int page, int limit) {
    _pagination.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void nextPage() {
    if (!lastPage) {
      _changePagination(_pagination.value.page + 1, _pagination.value.limit);
    }
  }

  Future<void> searchHistoryThisPatient() async {
    query = QueryBuilder<ParseObject>(ParseObject(EvolutionEntity.className));
    query.whereEqualTo(
        'patient',
        (ParseObject(ProfileEntity.className)..objectId = patientId)
            .toPointer());
    var splashController = Get.find<SplashController>();
    query.whereContainedIn(
        'expertise',
        splashController.userModel!.profile!.expertise!
            .map((e) => e.id)
            .toList());
    //+++
    evolutionHistory.clear();
    await listAll();
    log('$evolutionHistory', name: 'searchHistoryThisPatient');
  }

  Future<void> listAll() async {
    _loading(true);
    List<EvolutionModel> temp =
        await _evolutionRepository.list(query, pagination: _pagination.value);
    if (temp.isEmpty) {
      _lastPage(true);
    }
    evolutionHistory.addAll(temp);
    _loading(false);
  }
}
