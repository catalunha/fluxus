import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/data/b4a/entity/office_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ClientSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final ProfileRepository _profileRepository;
  ClientSearchController({
    required ProfileRepository profileRepository,
  }) : _profileRepository = profileRepository;

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
  List<String>? includeColumns;

  @override
  void onInit() {
    clientProfileList.clear();
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
    query = QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
    //Buscar apenas pacientes não equipe de profissionais

    if (nameContainsBool) {
      query.whereContains('name', nameContainsString);
    }
    if (cpfEqualToBool) {
      query.whereEqualTo('cpf', cpfEqualToString);
    }
    if (phoneEqualToBool) {
      query.whereEqualTo('phone', phoneEqualToString);
    }
    if (birthdayBool && selectedDate != null) {
      // selectedDate = selectedDate!.subtract(const Duration(hours: 3));
      print(selectedDate);
      // String dateToSearch = DateTime(selectedDate!.year, selectedDate!.month,
      //         selectedDate!.day, 00, 00, 00)
      //     .toIso8601String();
      // print('selectedDate: $dateToSearch');
      // print('selectedDate: $dateToSearch');
      // query.whereEqualTo('birthday', dateToSearch);
      // query.whereEqualTo('birthday', '2022-10-19T00:00:00');
      // query.whereEqualTo('birthday', '2022-10-19T00:00:000Z');
      query.whereEqualTo('birthday', selectedDate);
      // 2022-10-19T00:00:00.000Z
      // selectedDate = selectedDate!.add(const Duration(hours: 3));
      print(selectedDate);
    }

    if (query.queries.isEmpty) {
      if (allowedAccess(OfficeEnum.secretaria.id)) {
        //secretariado

      } else {
        query.whereEqualTo('objectId', '0');
      }
    }
    query.whereEqualTo(
        'office',
        (ParseObject(OfficeEntity.className)..objectId = 'RrrMr52QBM')
            .toPointer());

    clientProfileList.clear();
    if (lastPage) {
      _lastPage(false);
      _pagination.update((val) {
        val!.page = 1;
        val.limit = 12;
      });
    } else {
      await listAll();
    }
    // _changePagination(_pagination.value.page, _pagination.value.limit);
    _loading(false);
    Get.toNamed(Routes.clientProfileList);
  }

  bool allowedAccess(String officeId) {
    final splashController = Get.find<SplashController>();
    return splashController.officeIdList.contains(officeId);
  }

  Future<void> listAll() async {
    if (!lastPage) {
      _loading(true);
      List<ProfileModel> temp = await _profileRepository.list(
          query, _pagination.value,
          includeColumns: ['name', 'photo', 'birthday']);
      if (temp.isEmpty) {
        _lastPage.value = true;
      }
      clientProfileList.addAll(temp);
      _loading(false);
    }
  }
}
