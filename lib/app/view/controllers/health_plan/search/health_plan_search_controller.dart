import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/data/b4a/entity/health_plan_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/health_plan_repository.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HealthPlanSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final HealthPlanRepository _healthPlanRepository;
  HealthPlanSearchController({
    required HealthPlanRepository healthPlanRepository,
  }) : _healthPlanRepository = healthPlanRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<HealthPlanModel> healthPlanList = <HealthPlanModel>[].obs;
  // final _pagination = Pagination().obs;
  // final _lastPage = false.obs;
  // get lastPage => _lastPage.value;

  // final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
  // DateTime? get selectedDate => _selectedDate.value;
  // set selectedDate(DateTime? selectedDate1) {
  //   _selectedDate.value = selectedDate1;
  // }

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  @override
  void onInit() {
    healthPlanList.clear();
    // _changePagination(1, 12);
    // ever(_pagination, (_) => listAll());
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  // void _changePagination(int page, int limit) {
  //   _pagination.update((val) {
  //     val!.page = page;
  //     val.limit = limit;
  //   });
  // }

  // void nextPage() {
  //   _changePagination(_pagination.value.page + 1, _pagination.value.limit);
  // }

  Future<void> search({
    required bool codeContainsBool,
    required String codeContainsString,
  }) async {
    _loading(true);
    // if (!codeContainsBool) {
    query = QueryBuilder<ParseObject>(ParseObject(HealthPlanEntity.className));
    // }
    if (codeContainsBool) {
      query.whereContains('code', codeContainsString);
    }

    healthPlanList.clear();
    listAll();
    _loading(false);
    Get.toNamed(Routes.healthPlanList);
  }

  listAll() async {
    _loading(true);

    List<HealthPlanModel> temp = await _healthPlanRepository.list(query);
    // if (temp.isEmpty) {
    //   _lastPage.value = true;
    // }
    healthPlanList.addAll(temp);
    _loading(false);
  }
}
