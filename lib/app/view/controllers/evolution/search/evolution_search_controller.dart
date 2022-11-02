import 'dart:developer';

import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/b4a/entity/evolution_entity.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EvolutionSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final EvolutionRepository _evolutionRepository;
  EvolutionSearchController({
    required EvolutionRepository evolutionRepository,
  }) : _evolutionRepository = evolutionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  var evolutionList = <EvolutionModel>[].obs;

  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(EvolutionEntity.className));

  @override
  void onInit() {
    evolutionList.clear();
    _changePagination(1, 12);
    ever(_pagination, (_) async => await listAll());
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  void _changePagination(int page, int limit) {
    _pagination.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void nextPage() {
    _changePagination(_pagination.value.page + 1, _pagination.value.limit);
  }

  Future<void> search({
    required bool isArchived,
    // required String nameContainsString,
    // required bool cpfEqualToBool,
    // required String cpfEqualToString,
    // required bool phoneEqualToBool,
    // required String phoneEqualToString,
    // required bool birthdayBool,
  }) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(EvolutionEntity.className));
    var splashController = Get.find<SplashController>();
    String professionalId = splashController.userModel!.profile!.id!;
    // query.whereEqualTo(
    //     'professional',
    //     (ParseObject(ProfileEntity.className)..objectId = professionalId)
    //         .toPointer());
    if (isArchived) {
      query.whereEqualTo('isArchived', isArchived);
    } else {
      query.whereEqualTo('isArchived', isArchived);
    }
    evolutionList.clear();
    if (lastPage) {
      _lastPage(false);
      _pagination.update((val) {
        val!.page = 1;
        val.limit = 12;
      });
      // _changePagination(_pagination.value.page, _pagination.value.limit);
    } else {
      await listAll();
    }
    _loading(false);
    Get.toNamed(Routes.evolutionList);
  }

  Future<void> listAll() async {
    _loading(true);
    log('+++', name: 'EvolutionSearchController.listAll');
    List<EvolutionModel> temp =
        await _evolutionRepository.list(query, _pagination.value);
    if (temp.isEmpty) {
      _lastPage.value = true;
    }
    evolutionList.addAll(temp);
    _loading(false);
  }
}
