import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/expect_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/utils/allowed_access.dart';
import 'package:fluxus/app/data/b4a/entity/expect_entity.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
import 'package:fluxus/app/data/b4a/entity/expertise_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/expect_repository.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/expertise_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ExpectSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final ExpectRepository _expectRepository;
  final EventStatusRepository _eventStatusRepository;
  final ExpertiseRepository _expertiseRepository;

  ExpectSearchController({
    required ExpectRepository expectRepository,
    required EventStatusRepository eventStatusRepository,
    required ExpertiseRepository expertiseRepository,
  })  : _expectRepository = expectRepository,
        _eventStatusRepository = eventStatusRepository,
        _expertiseRepository = expertiseRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ExpectModel> expectList = <ExpectModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  final Rxn<DateTime> _dAutorization = Rxn<DateTime>();
  DateTime? get dAutorization => _dAutorization.value;
  set dAutorization(DateTime? dAutorization1) {
    _dAutorization.value = dAutorization1;
  }

  var eventStatusList = <EventStatusModel>[].obs;
  final _eventStatusSelected = Rxn<EventStatusModel>();
  EventStatusModel? get eventStatusSelected => _eventStatusSelected.value;
  set eventStatusSelected(EventStatusModel? newModel) =>
      _eventStatusSelected(newModel);

  var expertiseList = <ExpertiseModel>[].obs;
  final _expertiseSelected = Rxn<ExpertiseModel>();
  ExpertiseModel? get expertiseSelected => _expertiseSelected.value;
  set expertiseSelected(ExpertiseModel? newModel) =>
      _expertiseSelected(newModel);

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  @override
  void onInit() {
    expectList.clear();
    _changePagination(1, 12);
    ever(_pagination, (_) async => await listAll());
    loaderListener(_loading);
    messageListener(_message);
    getEventStatusList();
    getExpertiseList();
    super.onInit();
  }

  getEventStatusList() async {
    List<EventStatusModel> all = await _eventStatusRepository.list();

    var eventStatusAutorized = [
      'zoFBVNZ16I',
      '0kCQxw8GBb',
      'TBlbt1gbW3',
    ];
    for (var eventStatus in all) {
      if (eventStatusAutorized.contains(eventStatus.id)) {
        eventStatusList.add(eventStatus);
      }
    }
    eventStatusSelected = eventStatusList[0];
  }

  getExpertiseList() async {
    List<ExpertiseModel> all = await _expertiseRepository.list();
    expertiseList(all);
    expertiseSelected = expertiseList[0];
    expertiseSelected = expertiseList[0];
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
    required bool patientEqualToBool,
    required String patientEqualToString,
    required bool eventStatusEqualToBool,
    required bool expertiseEqualToBool,
  }) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(ExpectEntity.className));
    if (isArchived) {
      query.whereEqualTo('isArchived', isArchived);
    } else {
      query.whereEqualTo('isArchived', isArchived);
    }
    if (patientEqualToBool) {
      query.whereEqualTo(
          'patient',
          (ParseObject(ProfileEntity.className)
                ..objectId = patientEqualToString)
              .toPointer());
    }

    if (eventStatusEqualToBool) {
      query.whereEqualTo(
          'eventStatus',
          (ParseObject(EventStatusEntity.className)
                ..objectId = eventStatusSelected!.id)
              .toPointer());
    }
    if (AllowedAccess.consultFor([OfficeEnum.avaliadora.id])) {
      final splashController = Get.find<SplashController>();
      List<QueryBuilder<ParseObject>> queryBuilderList = [];
      for (var expertise in splashController.userModel!.profile!.expertise!) {
        var query1 =
            QueryBuilder<ParseObject>(ParseObject(ExpectEntity.className));
        query1.whereEqualTo(
            'expertise',
            (ParseObject(ExpertiseEntity.className)..objectId = expertise.id)
                .toPointer());
        queryBuilderList.add(query1);
      }
      QueryBuilder<ParseObject> queryOr =
          QueryBuilder<ParseObject>(ParseObject(ExpectEntity.className));

      queryOr = QueryBuilder.or(
        ParseObject(ExpectEntity.className),
        queryBuilderList,
      );

      query.whereMatchesKeyInQuery('expertise', 'expertise', queryOr);
    }
    if (expertiseEqualToBool) {
      query.whereEqualTo(
          'expertise',
          (ParseObject(ExpertiseEntity.className)
                ..objectId = expertiseSelected!.id)
              .toPointer());
    }

    expectList.clear();
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
    Get.toNamed(Routes.expectList);
  }

  Future<void> listAll() async {
    if (!lastPage) {
      _loading(true);
      List<ExpectModel> temp =
          await _expectRepository.list(query, _pagination.value);
      if (temp.isEmpty) {
        _lastPage.value = true;
      }
      expectList.addAll(temp);
      _loading(false);
    }
  }

  archiveExpect(ExpectModel expectModel, bool isArchived) {
    try {
      _expectRepository.update(expectModel.copyWith(isArchived: isArchived));
    } catch (e) {
      _message.value = MessageModel(
        title: 'Erro em archiveExpect',
        message: 'Não foi possivel arquivar',
        isError: true,
      );
    }
  }
}
