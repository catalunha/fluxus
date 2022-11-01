import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/data/b4a/entity/attendance_entity.dart';
import 'package:fluxus/app/data/b4a/entity/event_entity.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/b4a/entity/room_entity.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class EventSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final EventRepository _eventRepository;
  EventSearchController({
    required EventRepository eventRepository,
  }) : _eventRepository = eventRepository;

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

  final Rxn<DateTime> _dtEnd = Rxn<DateTime>();
  DateTime? get dtEnd => _dtEnd.value;
  set dtEnd(DateTime? dtEnd1) {
    _dtEnd.value = dtEnd1;
  }

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  @override
  void onInit() {
    eventList.clear();
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
          'start', DateTime(dtStart!.year, dtStart!.month, dtStart!.day));
      query.whereLessThanOrEqualTo('start',
          DateTime(dtStart!.year, dtStart!.month, dtStart!.day, 23, 59));
    }

    if (eventStatusEqualToBool) {
      query.whereEqualTo(
        'status',
        (ParseObject(EventStatusEntity.className)
              ..objectId = eventStatusEqualToString)
            .toPointer(),
      );
    }
    if (roomEqualToBool) {
      query.whereEqualTo(
        'room',
        (ParseObject(RoomEntity.className)..objectId = roomEqualToString)
            .toPointer(),
      );
    }
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
