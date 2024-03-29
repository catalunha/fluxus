import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/enums/event_status_enum.dart';
import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/core/utils/start_date_drop_down.dart';
import 'package:fluxus/app/data/b4a/table/attendance/attendance_repository_exception.dart';
import 'package:fluxus/app/data/b4a/table/event/event_repository_exception.dart';
import 'package:fluxus/app/data/repositories/attendance_repository.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/data/repositories/procedure_repository.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final EventRepository _eventRepository;
  final RoomRepository _roomRepository;
  final EventStatusRepository _eventStatusRepository;
  final ProcedureRepository _procedureRepository;
  final EvolutionRepository _evolutionRepository;
  final AttendanceRepository _attendanceRepository;

  EventAddEditController({
    required EventRepository eventRepository,
    required RoomRepository roomRepository,
    required EventStatusRepository eventStatusRepository,
    required ProcedureRepository procedureRepository,
    required EvolutionRepository evolutionRepository,
    required AttendanceRepository attendanceRepository,
  })  : _eventRepository = eventRepository,
        _roomRepository = roomRepository,
        _eventStatusRepository = eventStatusRepository,
        _procedureRepository = procedureRepository,
        _evolutionRepository = evolutionRepository,
        _attendanceRepository = attendanceRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _event = Rxn<EventModel>();
  EventModel? get event => _event.value;
  set event(EventModel? eventModelNew) => _event(eventModelNew);

//+++ Datas

  final Rxn<DateTime> _dateStart = Rxn<DateTime>();
  DateTime? get dateStart => _dateStart.value;
  set dateStart(DateTime? newDate) {
    _dateStart(newDate);
    _dateEnd(newDate);
    // if (nemDate != null) {
    //   _dateStart(DateTime(nemDate.year, nemDate.month, nemDate.day));
    //   _dateEnd(DateTime(nemDate.year, nemDate.month, nemDate.day));
    // }
  }

  final Rxn<DateTime> _dateEnd = Rxn<DateTime>();
  DateTime? get dateEnd => _dateEnd.value;
  set dateEnd(DateTime? newDate) {
    _dateEnd(newDate);
    // if (nemDate != null) {
    //   _dateEnd(DateTime(nemDate.year, nemDate.month, nemDate.day));
    // }
  }

  // setDateStartTime(int hour, int minute) {
  //   if (dateStart != null) {
  //     _dateStart(DateTime(
  //         dateStart!.year, dateStart!.month, dateStart!.day, hour, minute));
  //   }
  // }

  // setDateEndTime(int hour, int minute) {
  //   if (dateStart != null) {
  //     _dateEnd(DateTime(
  //         dateStart!.year, dateStart!.month, dateStart!.day, hour, minute));
  //   }
  // }
  var startDateList = <StartDateDropDrow>[].obs;
  // StartDateDropDrow? startDateDropDrowSelected;
  final _startDateDropDrowSelected = Rxn<StartDateDropDrow>();
  StartDateDropDrow? get startDateDropDrowSelected =>
      _startDateDropDrowSelected.value;
  set startDateDropDrowSelected(StartDateDropDrow? newModel) =>
      _startDateDropDrowSelected(newModel);

  // StartDateDropDrow? endDateDropDrowSelected;
  final _endDateDropDrowSelected = Rxn<StartDateDropDrow>();
  StartDateDropDrow? get endDateDropDrowSelected =>
      _endDateDropDrowSelected.value;
  set endDateDropDrowSelected(StartDateDropDrow? newModel) =>
      _endDateDropDrowSelected(newModel);

//--- Datas

  var attendanceConfirmedPresence = <String, bool?>{}.obs;

  var roomList = <RoomModel>[].obs;
  final _roomModelSelected = Rxn<RoomModel>();
  RoomModel? get roomModelSelected => _roomModelSelected.value;
  set roomModelSelected(RoomModel? newModel) => _roomModelSelected(newModel);

  var eventStatusList = <EventStatusModel>[].obs;
  final _eventStatusSelected = Rxn<EventStatusModel>();
  EventStatusModel? get eventStatusSelected => _eventStatusSelected.value;
  set eventStatusSelected(EventStatusModel? newModel) =>
      _eventStatusSelected(newModel);

  // var procedureList = <ProcedureModel>[].obs;
  // final _expertiseModelSelected = Rxn<ProcedureModel>();
  // ProcedureModel? get expertiseModelSelected => _expertiseModelSelected.value;
  // set expertiseModelSelected(ProcedureModel? newModel) =>
  //     _expertiseModelSelected(newModel);

  String? eventId;

  List<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  List<AttendanceModel> attendanceListOriginal = <AttendanceModel>[];

//+++ forms
  // final autorizationTec = TextEditingController();
  // final faturaTec = TextEditingController();
  final descriptionTec = TextEditingController();
//--- forms
  @override
  void onReady() async {
    eventId = Get.arguments;
    await getEvent();
    getEventStatusList();
    getRoomList();
    super.onReady();
  }

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    getStartDateList();
    super.onInit();
  }

  getRoomList() async {
    List<RoomModel> all = await _roomRepository.list();
    roomList(all);
    roomModelSelected = roomList[0];
  }

  getEventStatusList() async {
    List<EventStatusModel> all = await _eventStatusRepository.list();
    List<String> eventStatusAutorized = [];
    if (allowedAccess(OfficeEnum.secretaria.id)) {
      eventStatusAutorized = [
        EventStatusEnum.indefinido.id,
        EventStatusEnum.eventoAgendado.id,
        EventStatusEnum.eventoFinalizado.id,
        // EventStatusEnum.pacienteNaoCompareceu.id,
        EventStatusEnum.pacienteCancelou.id,
        EventStatusEnum.profissionalCancelou.id,
      ];
    } else {
      eventStatusAutorized = [
        EventStatusEnum.eventoAtendido.id,
      ];
    }
    for (var eventStatus in all) {
      if (eventStatusAutorized.contains(eventStatus.id)) {
        eventStatusList.add(eventStatus);
      }
    }
    if (eventId == null) {
      eventStatusSelected = eventStatusList[0];
    } else {
      // eventStatusSelected = eventStatusList[0];
      eventStatusSelected = event!.eventStatus;
    }
  }

  bool allowedAccess(String officeId) {
    final splashController = Get.find<SplashController>();
    return splashController.officeIdList.contains(officeId);
  }
  // getProcedureList() async {
  //   List<ProcedureModel> all = await _procedureRepository.list();
  //   procedureList(all);
  // }

  Future<void> getEvent() async {
    _loading(true);
    if (eventId != null) {
      //log('${event?.start}', name: 'getEvent1');
      EventModel? eventModelTemp = await _eventRepository.readById(eventId!);
      //log('${eventModelTemp!.start}', name: 'getEvent2');
      event = eventModelTemp;
      if (eventModelTemp?.attendance != null) {
        attendanceList.addAll([...eventModelTemp!.attendance!]);
        attendanceListOriginal.addAll([...eventModelTemp.attendance!]);
        for (var attendance in attendanceList) {
          attendanceConfirmedPresence[attendance.id!] =
              attendance.confirmedPresence;
        }
      }
      //log('${event?.start}', name: 'getEvent3');
      onSetStatus();
      onSetDates();
      onSetRoom();
    }
    setFormFieldControllers();
    _loading(false);
  }

  getStartDateList() {
    List<StartDateDropDrow> all = [
      StartDateDropDrow(name: '08:00', hour: 8, minute: 0),
      StartDateDropDrow(name: '08:10', hour: 8, minute: 10),
      StartDateDropDrow(name: '08:20', hour: 8, minute: 20),
      StartDateDropDrow(name: '08:30', hour: 8, minute: 30),
      StartDateDropDrow(name: '08:40', hour: 8, minute: 40),
      StartDateDropDrow(name: '08:50', hour: 8, minute: 50),
      StartDateDropDrow(name: '09:00', hour: 9, minute: 0),
      StartDateDropDrow(name: '09:10', hour: 9, minute: 10),
      StartDateDropDrow(name: '09:20', hour: 9, minute: 20),
      StartDateDropDrow(name: '09:30', hour: 9, minute: 30),
      StartDateDropDrow(name: '09:40', hour: 9, minute: 40),
      StartDateDropDrow(name: '09:50', hour: 9, minute: 50),
      StartDateDropDrow(name: '10:00', hour: 10, minute: 0),
      StartDateDropDrow(name: '10:10', hour: 10, minute: 10),
      StartDateDropDrow(name: '10:20', hour: 10, minute: 20),
      StartDateDropDrow(name: '10:30', hour: 10, minute: 30),
      StartDateDropDrow(name: '10:40', hour: 10, minute: 40),
      StartDateDropDrow(name: '10:50', hour: 10, minute: 50),
      StartDateDropDrow(name: '11:00', hour: 11, minute: 0),
      StartDateDropDrow(name: '11:10', hour: 11, minute: 10),
      StartDateDropDrow(name: '11:20', hour: 11, minute: 20),
      StartDateDropDrow(name: '11:30', hour: 11, minute: 30),
      StartDateDropDrow(name: '11:40', hour: 11, minute: 40),
      StartDateDropDrow(name: '11:50', hour: 11, minute: 50),
      StartDateDropDrow(name: '12:00', hour: 12, minute: 0),
      StartDateDropDrow(name: '12:10', hour: 12, minute: 10),
      StartDateDropDrow(name: '12:20', hour: 12, minute: 20),
      StartDateDropDrow(name: '12:30', hour: 12, minute: 30),
      StartDateDropDrow(name: '12:40', hour: 12, minute: 40),
      StartDateDropDrow(name: '12:50', hour: 12, minute: 50),
      StartDateDropDrow(name: '13:00', hour: 13, minute: 0),
      StartDateDropDrow(name: '13:10', hour: 13, minute: 10),
      StartDateDropDrow(name: '13:20', hour: 13, minute: 20),
      StartDateDropDrow(name: '13:30', hour: 13, minute: 30),
      StartDateDropDrow(name: '13:40', hour: 13, minute: 40),
      StartDateDropDrow(name: '13:50', hour: 13, minute: 50),
      StartDateDropDrow(name: '14:00', hour: 14, minute: 0),
      StartDateDropDrow(name: '14:10', hour: 14, minute: 10),
      StartDateDropDrow(name: '14:20', hour: 14, minute: 20),
      StartDateDropDrow(name: '14:30', hour: 14, minute: 30),
      StartDateDropDrow(name: '14:40', hour: 14, minute: 40),
      StartDateDropDrow(name: '14:50', hour: 14, minute: 50),
      StartDateDropDrow(name: '15:00', hour: 15, minute: 0),
      StartDateDropDrow(name: '15:10', hour: 15, minute: 10),
      StartDateDropDrow(name: '15:20', hour: 15, minute: 20),
      StartDateDropDrow(name: '15:30', hour: 15, minute: 30),
      StartDateDropDrow(name: '15:40', hour: 15, minute: 40),
      StartDateDropDrow(name: '15:50', hour: 15, minute: 50),
      StartDateDropDrow(name: '16:00', hour: 16, minute: 0),
      StartDateDropDrow(name: '16:10', hour: 16, minute: 10),
      StartDateDropDrow(name: '16:20', hour: 16, minute: 20),
      StartDateDropDrow(name: '16:30', hour: 16, minute: 30),
      StartDateDropDrow(name: '16:40', hour: 16, minute: 40),
      StartDateDropDrow(name: '16:50', hour: 16, minute: 50),
      StartDateDropDrow(name: '17:00', hour: 17, minute: 0),
      StartDateDropDrow(name: '17:10', hour: 17, minute: 10),
      StartDateDropDrow(name: '17:20', hour: 17, minute: 20),
      StartDateDropDrow(name: '17:30', hour: 17, minute: 30),
      StartDateDropDrow(name: '17:40', hour: 17, minute: 40),
      StartDateDropDrow(name: '17:50', hour: 17, minute: 50),
      StartDateDropDrow(name: '18:00', hour: 18, minute: 0),
      StartDateDropDrow(name: '18:10', hour: 18, minute: 10),
      StartDateDropDrow(name: '18:20', hour: 18, minute: 20),
      StartDateDropDrow(name: '18:30', hour: 18, minute: 30),
      StartDateDropDrow(name: '18:40', hour: 18, minute: 40),
      StartDateDropDrow(name: '18:50', hour: 18, minute: 50),
    ];
    startDateList(all);
  }

  onUpdateStartChangeEnd(StartDateDropDrow startDateDropDrow) {
    int indexOfStart = startDateList.indexOf(startDateDropDrow);
    int salto = 4;
    if (indexOfStart < startDateList.length - salto) {
      _endDateDropDrowSelected(startDateList[indexOfStart + salto]);
    }
    dateStart = onMountDateStart();
    dateEnd = onMountDateEnd();
    // log('${onMountDateStart()}', name: 'onUpdateEnd');
    // log('$startDateDropDrowSelected', name: 'onUpdateEnd');
    // log('${startDateDropDrowSelected?.hour}', name: 'onUpdateEnd');
    // log('${startDateDropDrowSelected?.minute}', name: 'onUpdateEnd');
    // log('$endDateDropDrowSelected', name: 'onUpdateEnd');
    // log('${endDateDropDrowSelected?.hour}', name: 'onUpdateEnd');
    // log('${endDateDropDrowSelected?.minute}', name: 'onUpdateEnd');
    // log('$dateStart', name: 'onUpdateEnd');
    // log('$dateEnd', name: 'onUpdateEnd');
  }

  onUpdateEnd(StartDateDropDrow startDateDropDrow) {
    dateEnd = onMountDateEnd();
    // log('${onMountDateStart()}', name: 'onUpdateEnd');
    // log('$startDateDropDrowSelected', name: 'onUpdateEnd');
    // log('${startDateDropDrowSelected?.hour}', name: 'onUpdateEnd');
    // log('${startDateDropDrowSelected?.minute}', name: 'onUpdateEnd');
    // log('$endDateDropDrowSelected', name: 'onUpdateEnd');
    // log('${endDateDropDrowSelected?.hour}', name: 'onUpdateEnd');
    // log('${endDateDropDrowSelected?.minute}', name: 'onUpdateEnd');
    // log('$dateStart', name: 'onUpdateEnd');
    // log('$dateEnd', name: 'onUpdateEnd');
  }

  void onSetDates() {
    log('event?.dtStart: ${event?.dtStart}', name: 'onSetDates');
    log('event?.dtEnd: ${event?.dtEnd}', name: 'onSetDates');
    _dateStart(event?.dtStart);
    if (dateStart != null) {
      startDateDropDrowSelected = startDateList.firstWhereOrNull((element) {
        return element.hour == dateStart!.hour &&
            element.minute == dateStart!.minute;
      });
    }
    _dateEnd(event?.dtEnd);
    if (dateEnd != null) {
      endDateDropDrowSelected = startDateList.firstWhereOrNull((element) =>
          element.hour == dateEnd!.hour && element.minute == dateEnd!.minute);
    }
  }

  void onSetRoom() {
    _roomModelSelected(event?.room);
  }

  void onSetStatus() {
    // if (allowedAccess(OfficeEnum.secretaria.id)) {
    eventStatusSelected = event?.eventStatus;
    // }
    print('eventStatusSelected?.name: ${eventStatusSelected?.name}');
  }

  setFormFieldControllers() {
    // autorizationTec.text = event?.autorization ?? "";
    // faturaTec.text = event?.fatura ?? "";
    descriptionTec.text = "";
    // descriptionTec.text = event?.description ?? "";
  }

  DateTime? onMountDateStart() {
    return DateTime(dateStart!.year, dateStart!.month, dateStart!.day,
        startDateDropDrowSelected!.hour!, startDateDropDrowSelected!.minute!);
  }

  DateTime? onMountDateEnd() {
    return DateTime(dateEnd!.year, dateEnd!.month, dateEnd!.day,
        endDateDropDrowSelected!.hour!, endDateDropDrowSelected!.minute!);
  }

  Future<void> append({
    RoomModel? room,
    EventStatusModel? status,
    String? description,
    bool? isDeleted,
  }) async {
    try {
      dateStart = onMountDateStart();
      dateEnd = onMountDateEnd();
      _loading(true);
      // dateStart = onMountDateStart();
      // dateEnd = onMountDateEnd();
      String logData = '---------------------';
      final dateFormat = DateFormat('dd/MM/y hh:mm');
      logData = '$logData\n${dateFormat.format(DateTime.now())}';
      var splashController = Get.find<SplashController>();
      logData = '$logData\nUser: ${splashController.userModel!.email}';
      logData = '$logData\nSala: ${room?.name ?? '-'}';
      logData = '$logData\nInício: ${dateStart ?? '-'}';
      // logData = '$logData\nend:${dateEnd ?? '-'}';
      logData = '$logData\nDesc.:${description ?? '-'}';
      logData = '$logData\nStatus:${status?.name ?? '-'}';
      logData = '$logData\n${event?.log ?? "\n-------------------\nInicio."}';
      // String? eventStatusIdPast = event?.status?.id;
      if (eventId == null) {
        event = EventModel(
          room: room,
          dtStart: dateStart,
          dtEnd: dateEnd,
          eventStatus: status,
          description: description,
          isDeleted: isDeleted,
          log: logData,
        );
      } else {
        event = event!.copyWith(
          room: room,
          dtStart: dateStart,
          dtEnd: dateEnd,
          eventStatus: status,
          description: description,
          isDeleted: isDeleted,
          log: logData,
        );
      }
      String eventIdTemp = await _eventRepository.update(event!);
      await updateAttendanceInEvent(eventIdTemp);

      eventId = eventIdTemp;
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

  Future<void> addAttendance(String attendanceId) async {
    try {
      _loading(true);
      var attendance = await _attendanceRepository.readById(attendanceId);
      if (attendance != null) {
        attendanceList.add(attendance);
      }
    } on AttendanceRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em EventController',
        message: 'Não foi possivel salvar o atendimento',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }

  removeAttendance(String attendanceId) {
    print(attendanceId);
    attendanceList.removeWhere((element) => element.id == attendanceId);
  }

  Future<void> updateAttendanceInEvent(String eventId) async {
    List<AttendanceModel> attendanceListResult = <AttendanceModel>[];
    attendanceListResult.addAll([...attendanceList]);
    for (var attendanceOriginal in attendanceListOriginal) {
      var attendanceFound = attendanceList
          .firstWhereOrNull((element) => element.id == attendanceOriginal.id);
      if (attendanceFound == null) {
        await updateAttendanceData(eventId, attendanceOriginal, false);
        await _eventRepository.updateRelationAttendance(
            eventId, [attendanceOriginal.id!], false);
      } else {
        await updateAttendanceData(eventId, attendanceFound, true);
        attendanceListResult
            .removeWhere((element) => element.id == attendanceFound.id);
      }
    }
    for (var attendanceResult in attendanceListResult) {
      await _eventRepository.updateRelationAttendance(
          eventId, [attendanceResult.id!], true);
      await updateAttendanceData(eventId, attendanceResult, true);
    }
  }

  Future<void> updateAttendanceData(
      String eventId, AttendanceModel attendanceModel, bool add) async {
    if (add) {
      await _attendanceRepository.update(
        AttendanceModel(
          id: attendanceModel.id,
          event: eventId,
          dtAttendance: dateStart,
          eventStatus: eventStatusSelected,
        ),
      );
      await _evolutionRepository.update(
        EvolutionModel(
            id: attendanceModel.evolution,
            event: eventId,
            dtAttendance: dateStart),
      );
    } else {
      await _attendanceRepository
          .updateUnset(attendanceModel.id!, ['event', 'dtAttendance']);
      await _attendanceRepository.update(
        AttendanceModel(
          id: attendanceModel.id,
          eventStatus: EventStatusModel(id: 'uvHmcIKiFc'),
        ),
      );
      await _evolutionRepository
          .updateUnset(attendanceModel.id!, ['event', 'dtAttendance']);
    }
  }

  Future<void> updateAttendanceConfirmedPresence(String attendanceId) async {
    _loading(true);
    if (attendanceConfirmedPresence[attendanceId] == null) {
      await _attendanceRepository.update(
        AttendanceModel(id: attendanceId, confirmedPresence: true),
      );
      attendanceConfirmedPresence[attendanceId] = true;
    } else if (attendanceConfirmedPresence[attendanceId] == true) {
      await _attendanceRepository.update(
        AttendanceModel(id: attendanceId, confirmedPresence: false),
      );
      attendanceConfirmedPresence[attendanceId] = false;
    } else {
      await _attendanceRepository
          .updateUnset(attendanceId, ['confirmedPresence']);
      attendanceConfirmedPresence[attendanceId] = null;
    }
    _loading(false);
  }
}
