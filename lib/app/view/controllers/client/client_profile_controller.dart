import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ClientProfileController extends GetxController
    with LoaderMixin, MessageMixin {
  final ProfileRepository _profileRepository;
  // final HealthPlanRepository _healthPlanRepository;
  // final HealthPlanTypeRepository _healthPlanTypeRepository;
  ClientProfileController({
    required ProfileRepository profileRepository,
    // required HealthPlanRepository healthPlanRepository,
    // required HealthPlanTypeRepository healthPlanTypeRepository,
  }) : _profileRepository = profileRepository;
  // _healthPlanRepository = healthPlanRepository,
  // _healthPlanTypeRepository = healthPlanTypeRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ProfileModel> clientProfileList = <ProfileModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  final Rxn<DateTime> _selectedDate = Rxn<DateTime>();
  DateTime? get selectedDate => _selectedDate.value;
  set selectedDate(DateTime? selectedDate1) {
    _selectedDate.value = selectedDate1;
  }

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  @override
  void onInit() {
    clientProfileList.clear();
    _changePagination(1, 12);
    ever(_pagination, (_) => listAll());
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
    required bool nameContainsBool,
    required String nameContainsString,
    required bool cpfEqualToBool,
    required String cpfEqualToString,
    required bool phoneEqualToBool,
    required String phoneEqualToString,
    required bool birthdayBool,
  }) async {
    _loading(true);
    clientProfileList.clear();
    if (!nameContainsBool &&
        !cpfEqualToBool &&
        !phoneEqualToBool &&
        !birthdayBool) {
      query = QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    }
    if (nameContainsBool) {
      query.whereContains('name', nameContainsString);
    }
    if (cpfEqualToBool) {
      query.whereEqualTo('cpf', cpfEqualToString);
    }
    if (phoneEqualToBool) {
      query.whereEqualTo('phone', phoneEqualToString);
    }
    if (birthdayBool) {
      selectedDate = selectedDate!.subtract(const Duration(hours: 3));
      query.whereEqualTo('birthday', selectedDate);
      selectedDate = selectedDate!.add(const Duration(hours: 3));
    }

    listAll();
    _loading(false);
    Get.toNamed(Routes.clientProfileList);
  }

  listAll() async {
    _loading(true);

    List<ProfileModel> temp =
        await _profileRepository.softList(query, _pagination.value);
    if (temp.isEmpty) {
      _lastPage.value = true;
    }
    clientProfileList.addAll(temp);
    _loading(false);
  }
}