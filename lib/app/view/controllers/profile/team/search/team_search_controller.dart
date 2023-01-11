import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/office_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/office_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/office_repository.dart';
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
  final OfficeRepository _officeRepository;
  TeamSearchController({
    required ProfileRepository profileRepository,
    required OfficeRepository officeRepository,
  })  : _profileRepository = profileRepository,
        _officeRepository = officeRepository;
  @override
  void onReady() {
    getAllOffice();
    super.onReady();
  }

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ProfileModel> teamProfileList = <ProfileModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  List<OfficeModel> officeList = <OfficeModel>[].obs;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  List<String>? includeColumns;

  @override
  void onInit() {
    teamProfileList.clear();
    _changePagination(1, 12);
    ever(_pagination, (_) async => await listAll());
    loaderListener(_loading);
    messageListener(_message);
    includeColumns = Get.arguments;
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

  Future<void> search(Map<String, Office> officeNew) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    query.whereNotEqualTo(
        'office',
        (ParseObject(OfficeEntity.className)..objectId = OfficeEnum.paciente.id)
            .toPointer());

    for (var element in officeNew.entries) {
      if (element.value.status) {
        query.whereEqualTo(
            'office',
            (ParseObject(OfficeEntity.className)..objectId = element.key)
                .toPointer());
      }
    }

    teamProfileList.clear();
    if (lastPage) {
      _lastPage(false);
      _pagination.update((val) {
        val!.page = 1;
        val.limit = 12;
      });
    } else {
      await listAll();
    }
    _loading(false);
    Get.toNamed(Routes.teamProfileList);
  }

  Future<void> listAll() async {
    if (!lastPage) {
      _loading(true);

      List<ProfileModel> temp = await _profileRepository.list(
          query, _pagination.value,
          includeColumns: ['name', 'email', 'photo']);
      if (temp.isEmpty) {
        _lastPage(true);
      }
      teamProfileList.addAll(temp);
      _loading(false);
    }
  }

  Future<void> getAllOffice() async {
    _loading(true);

    List<OfficeModel> temp = await _officeRepository.list();
    // query.whereNotEqualTo(
    // 'office',
    // (ParseObject(OfficeEntity.className)..objectId = 'RrrMr52QBM')
    //     .toPointer());
    temp.removeWhere((element) => element.id == OfficeEnum.paciente.id);
    officeList.addAll(temp);
    for (var office in officeList) {
      officeOptions[office.id!] = Office(name: office.name!, status: false);
    }
    _loading(false);
  }

  var officeOptions = <String, Office>{}.obs;
  // Map<String, Office> office = {
  //   'wntNbb1000': Office(name: 'Avaliadora', status: false),
  //   '4Zr3rIyGUd': Office(name: 'Profissional', status: false),
  //   'X4IeGQuXAF': Office(name: 'Nutrição', status: false),
  //   '5HAGAKmBnF': Office(name: 'Psicologia', status: false),
  // };
}

class Office {
  String name;
  bool status;
  Office({
    required this.name,
    required this.status,
  });

  @override
  String toString() => 'Office(name: $name, status: $status)';
}
