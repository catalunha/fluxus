import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/data/b4a/entity/attendance_entity.dart';
import 'package:fluxus/app/data/b4a/entity/event_entity.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/entity/room_entity.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EventSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final EventRepository _eventRepository;
  final EventStatusRepository _eventStatusRepository;
  final RoomRepository _roomRepository;

  EventSearchController({
    required EventRepository eventRepository,
    required EventStatusRepository eventStatusRepository,
    required RoomRepository roomRepository,
  })  : _eventRepository = eventRepository,
        _roomRepository = roomRepository,
        _eventStatusRepository = eventStatusRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<EventModel> eventList = <EventModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  final Rxn<DateTime> _dtStart = Rxn<DateTime>();
  DateTime? get dtStart => _dtStart.value;
  set dtStart(DateTime? dtStart1) {
    _dtStart.value = dtStart1;
  }

  // final Rxn<DateTime> _dtEnd = Rxn<DateTime>();
  // DateTime? get dtEnd => _dtEnd.value;
  // set dtEnd(DateTime? dtEnd1) {
  //   _dtEnd.value = dtEnd1;
  // }
  var eventStatusList = <EventStatusModel>[].obs;
  final _eventStatusSelected = Rxn<EventStatusModel>();
  EventStatusModel? get eventStatusSelected => _eventStatusSelected.value;
  set eventStatusSelected(EventStatusModel? newModel) =>
      _eventStatusSelected(newModel);

  var roomList = <RoomModel>[].obs;
  final _roomSelected = Rxn<RoomModel>();
  RoomModel? get roomSelected => _roomSelected.value;
  set roomSelected(RoomModel? newModel) => _roomSelected(newModel);

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  @override
  void onInit() {
    eventList.clear();
    _changePagination(1, 12);
    ever(_pagination, (_) async => await listAll());
    loaderListener(_loading);
    messageListener(_message);
    getEventStatusList();
    getRoomList();

    super.onInit();
  }

  getEventStatusList() async {
    List<EventStatusModel> all = await _eventStatusRepository.list();
    eventStatusList(all);
    eventStatusSelected = eventStatusList[0];
  }

  getRoomList() async {
    List<RoomModel> all = await _roomRepository.list();
    roomList(all);
    roomSelected = roomList[0];
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
    required bool myAttendance,
    required bool attendanceEqualToBool,
    required String attendanceEqualToString,
    required bool dtStartBool,
    required bool eventStatusEqualToBool,
    required String eventStatusEqualToString,
    required bool roomEqualToBool,
    required String roomEqualToString,
  }) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(EventEntity.className));
    if (myAttendance) {
      QueryBuilder<ParseObject> queryAttendance =
          QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
      var splashController = Get.find<SplashController>();
      String professionalId = splashController.userModel!.profile!.id!;
      queryAttendance.whereEqualTo(
          'professional',
          (ParseObject(ProfileEntity.className)..objectId = professionalId)
              .toPointer());

      query.whereMatchesQuery('attendance', queryAttendance);
    }
    if (attendanceEqualToBool) {
      query.whereEqualTo(
          'attendance',
          (ParseObject(AttendanceEntity.className)
                ..objectId = attendanceEqualToString)
              .toPointer());
    }
    if (dtStartBool && dtStart != null) {
      // query.whereEqualTo('start', dtStart);
      query.whereGreaterThanOrEqualsTo(
          'dtStart', DateTime(dtStart!.year, dtStart!.month, dtStart!.day));
      query.whereLessThanOrEqualTo('dtStart',
          DateTime(dtStart!.year, dtStart!.month, dtStart!.day, 23, 59));
    }
    if (eventStatusEqualToBool) {
      query.whereEqualTo(
        'eventStatus',
        (ParseObject(EventStatusEntity.className)
              ..objectId = eventStatusSelected!.id)
            .toPointer(),
      );
    }
    // if (eventStatusEqualToBool) {
    //   query.whereEqualTo(
    //     'eventStatus',
    //     (ParseObject(EventStatusEntity.className)
    //           ..objectId = eventStatusEqualToString)
    //         .toPointer(),
    //   );
    // }
    if (roomEqualToBool) {
      query.whereEqualTo(
        'room',
        (ParseObject(RoomEntity.className)..objectId = roomSelected!.id)
            .toPointer(),
      );
    }
    // if (roomEqualToBool) {
    //   query.whereEqualTo(
    //     'room',
    //     (ParseObject(RoomEntity.className)..objectId = roomEqualToString)
    //         .toPointer(),
    //   );
    // }
    //
    eventList.clear();
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
    Get.toNamed(Routes.eventList);
  }

  Future<void> listAll() async {
    if (!lastPage) {
      _loading(true);
      List<EventModel> temp =
          await _eventRepository.list(query, _pagination.value);
      if (temp.isEmpty) {
        _lastPage.value = true;
      }
      eventList.addAll(temp);
      _loading(false);
    }
  }
}
