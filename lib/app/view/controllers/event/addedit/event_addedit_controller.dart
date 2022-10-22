import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/core/utils/start_date_drop_down.dart';
import 'package:fluxus/app/data/b4a/table/event/event_repository_exception.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class EventAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final EventRepository _eventRepository;
  final RoomRepository _roomRepository;
  final EventStatusRepository _eventStatusRepository;
  EventAddEditController({
    required EventRepository eventRepository,
    required RoomRepository roomRepository,
    required EventStatusRepository eventStatusRepository,
  })  : _eventRepository = eventRepository,
        _roomRepository = roomRepository,
        _eventStatusRepository = eventStatusRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _event = Rxn<EventModel>();
  EventModel? get event => _event.value;
  set event(EventModel? eventModelNew) => _event(eventModelNew);

  // final healthPlanList = <HealthPlanModel>[].obs;

  // final _healthPlan = Rxn<HealthPlanModel>();
  // HealthPlanModel? get healthPlan => _healthPlan.value;
  // set healthPlan(HealthPlanModel? healthPlanNew) => _healthPlan(healthPlanNew);

  final Rxn<DateTime> _dateStart = Rxn<DateTime>();
  DateTime? get dateStart => _dateStart.value;
  set dateStart(DateTime? nemDate) {
    if (nemDate != null) {
      _dateStart(DateTime(nemDate.year, nemDate.month, nemDate.day));
      _dateEnd(DateTime(nemDate.year, nemDate.month, nemDate.day));
    }
  }

  final Rxn<DateTime> _dateEnd = Rxn<DateTime>();
  DateTime? get dateEnd => _dateEnd.value;
  set dateEnd(DateTime? nemDate) {
    if (nemDate != null) {
      _dateEnd(DateTime(nemDate.year, nemDate.month, nemDate.day));
    }
  }

  setDateStartTime(int hour, int minute) {
    if (dateStart != null) {
      _dateStart(DateTime(
          dateStart!.year, dateStart!.month, dateStart!.day, hour, minute));
    }
  }

  setDateEndTime(int hour, int minute) {
    if (dateStart != null) {
      _dateEnd(DateTime(
          dateStart!.year, dateStart!.month, dateStart!.day, hour, minute));
    }
  }

  var roomList = <RoomModel>[].obs;
  var eventStatusList = <EventStatusModel>[].obs;
  var startDateList = <StartDateDropDrow>[].obs;
  String? eventId;

//+++ forms
  final autorizationTec = TextEditingController();
  final faturaTec = TextEditingController();
  final descriptionTec = TextEditingController();
//--- forms

  @override
  void onInit() async {
    log('+++> Controller onInit');
    loaderListener(_loading);
    messageListener(_message);
    getRoomList();
    getEventStatusList();
    getStartDateList();
    eventId = Get.arguments;
    super.onInit();
  }

  getRoomList() async {
    List<RoomModel> all = await _roomRepository.list();
    roomList(all);
  }

  getEventStatusList() async {
    List<EventStatusModel> all = await _eventStatusRepository.list();
    eventStatusList(all);
  }

  Future<void> getEvent() async {
    // _loading(true);
    if (eventId != null) {
      log('==>>>>', name: 'getEvent');
      EventModel? eventModelTemp = await _eventRepository.readById(eventId!);
      event = eventModelTemp;
      onSetDates();
    }
    setFormFieldControllers();
    // _loading(false);
  }

  getStartDateList() {
    List<StartDateDropDrow> all = [
      StartDateDropDrow(name: '08:00', hour: '08', minute: '00'),
      StartDateDropDrow(name: '08:15', hour: '08', minute: '15'),
    ];
    startDateList(all);
  }

  void onSetDates() {
    dateStart = event?.start;
    dateEnd = event?.end;
  }

  setFormFieldControllers() {
    autorizationTec.text = event?.autorization ?? "";
    faturaTec.text = event?.fatura ?? "";
    descriptionTec.text = event?.description ?? "";
  }

  Future<void> append({
    String? autorization,
    String? fatura,
    RoomModel? room,
    EventStatusModel? status,
    String? description,
    bool? isDeleted,
  }) async {
    try {
      _loading(true);
      if (eventId == null) {
        event = EventModel(
          autorization: autorization,
          fatura: fatura,
          room: room,
          start: dateStart,
          end: dateEnd,
          status: status,
          description: description,
          isDeleted: isDeleted,
        );
      } else {
        event = event!.copyWith(
          autorization: autorization,
          fatura: fatura,
          room: room,
          start: dateStart,
          end: dateEnd,
          status: status,
          description: description,
          isDeleted: isDeleted,
        );
      }
      eventId = await _eventRepository.update(event!);

      event = event!.copyWith(id: eventId);
    } on EventRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em EventController',
        message: 'Não foi possivel salvar o evento',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  // Future<void> familyUpdate({
  //   required String id,
  //   required bool isAdd,
  // }) async {
  //   try {
  //     _loading(true);

  //     await _eventRepository.updateRelationFamily(event!.id!, [id], isAdd);
  //     await _eventRepository.updateRelationFamily(id, [event!.id!], isAdd);

  //     // final SplashController splashController = Get.find();
  //     // await splashController.updateUserProfile();
  //     await getEvent();
  //   } on ProfileRepositoryException {
  //     _message.value = MessageModel(
  //       title: 'Erro em ProfileController',
  //       message: 'Não foi possivel salvar o perfil',
  //       isError: true,
  //     );
  //   } finally {
  //     _loading(false);
  //   }
  // }
}
