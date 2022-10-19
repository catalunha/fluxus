import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/office_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TeamSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final ProfileRepository _profileRepository;
  TeamSearchController({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ProfileModel> teamProfileList = <ProfileModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  @override
  void onInit() {
    teamProfileList.clear();
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

  Future<void> search(String type) async {
    _loading(true);
    // if (type == '') {
    // wntNbb1000
    query.whereEqualTo(
        'office',
        (ParseObject(OfficeEntity.className)..objectId = 'wntNbb1000')
            .toPointer());
    query.whereEqualTo(
        'office',
        (ParseObject(OfficeEntity.className)..objectId = '4Zr3rIyGUd')
            .toPointer());
    // }
    teamProfileList.clear();
    if (lastPage) {
      _lastPage(false);
      _changePagination(1, 12);
    } else {
      await listAll();
    }
    _loading(false);
    Get.toNamed(Routes.teamProfileList);
  }

  Future<void> listAll() async {
    if (!lastPage) {
      _loading(true);

      List<ProfileModel> temp =
          await _profileRepository.list(query, _pagination.value);
      if (temp.isEmpty) {
        _lastPage(true);
      }
      teamProfileList.addAll(temp);
      _loading(false);
    }
  }
}
