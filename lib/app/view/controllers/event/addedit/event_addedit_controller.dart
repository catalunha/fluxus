import 'package:flutter/widgets.dart';
import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/core/models/procedure_model.dart';
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

  var roomList = <RoomModel>[].obs;
  final _roomModelSelected = Rxn<RoomModel>();
  RoomModel? get roomModelSelected => _roomModelSelected.value;
  set roomModelSelected(RoomModel? newModel) => _roomModelSelected(newModel);

  var eventStatusList = <EventStatusModel>[].obs;
  final _eventStatusSelected = Rxn<EventStatusModel>();
  EventStatusModel? get eventStatusSelected => _eventStatusSelected.value;
  set eventStatusSelected(EventStatusModel? newModel) =>
      _eventStatusSelected(newModel);

  var procedureList = <ProcedureModel>[].obs;
  final _expertiseModelSelected = Rxn<ProcedureModel>();
  ProcedureModel? get expertiseModelSelected => _expertiseModelSelected.value;
  set expertiseModelSelected(ProcedureModel? newModel) =>
      _expertiseModelSelected(newModel);

  String? eventId;

  List<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  List<AttendanceModel> attendanceListOriginal = <AttendanceModel>[];

//+++ forms
  // final autorizationTec = TextEditingController();
  // final faturaTec = TextEditingController();
  final descriptionTec = TextEditingController();
//--- forms
  @override
  void onReady() {
    eventId = Get.arguments;
    getEvent();
    super.onReady();
  }

  @override
  void onInit() async {
    //log('+++> EventAddEditController onInit');
    loaderListener(_loading);
    messageListener(_message);
    getRoomList();
    getEventStatusList();
    // getProcedureList();
    getStartDateList();
    //log(eventId ?? 'null', name: 'EventAddEditController');
    // getEvent();
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
      }
      //log('${event?.start}', name: 'getEvent3');
      onSetDates();
      onSetRoom();
      onSetStatus();
    }
    setFormFieldControllers();
    _loading(false);
  }

  getStartDateList() {
    List<StartDateDropDrow> all = [
      StartDateDropDrow(name: '08:00', hour: 8, minute: 0),
      StartDateDropDrow(name: '08:15', hour: 8, minute: 15),
      StartDateDropDrow(name: '08:30', hour: 8, minute: 30),
      StartDateDropDrow(name: '09:00', hour: 9, minute: 0),
    ];
    startDateList(all);
  }

  onUpdateEnd(StartDateDropDrow startDateDropDrow) {
    int indexOfStart = startDateList.indexOf(startDateDropDrow);
    int salto = 2;
    if (indexOfStart < startDateList.length - salto) {
      _endDateDropDrowSelected(startDateList[indexOfStart + salto]);
    }
  }

  void onSetDates() {
    _dateStart(event?.start);
    //log('$dateStart', name: 'onSetDates1');
    if (dateStart != null) {
      startDateDropDrowSelected = startDateList.firstWhereOrNull((element) =>
          element.hour == dateStart!.hour &&
          element.minute == dateStart!.minute);
    }
    _dateEnd(event?.end);
    if (dateEnd != null) {
      endDateDropDrowSelected = startDateList.firstWhereOrNull((element) =>
          element.hour == dateEnd!.hour && element.minute == dateEnd!.minute);
    }
  }

  void onSetRoom() {
    _roomModelSelected(event?.room);
  }

  void onSetStatus() {
    _eventStatusSelected(event?.status);
  }

  setFormFieldControllers() {
    // autorizationTec.text = event?.autorization ?? "";
    // faturaTec.text = event?.fatura ?? "";
    descriptionTec.text = event?.description ?? "";
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
      _loading(true);
      String logData = event?.log ?? '+++';
      logData = '$logData\n+++${DateTime.now()}';
      var splashController = Get.find<SplashController>();
      logData = '$logData\nuser:${splashController.userModel!.email}';
      logData = '$logData\nstart:${onMountDateStart() ?? '-'}';
      logData = '$logData\nend:${onMountDateEnd() ?? '-'}';
      logData = '$logData\ndesc:${description ?? '-'}';
      logData = '$logData\nroom:${room?.name ?? '-'}';
      logData = '$logData\nstatus:${status?.name ?? '-'}';
      // String? eventStatusIdPast = event?.status?.id;
      if (eventId == null) {
        event = EventModel(
          room: room,
          start: onMountDateStart(),
          end: onMountDateEnd(),
          status: status,
          description: description,
          isDeleted: isDeleted,
          log: logData,
        );
      } else {
        event = event!.copyWith(
          room: room,
          start: onMountDateStart(),
          end: onMountDateEnd(),
          status: status,
          description: description,
          isDeleted: isDeleted,
          log: logData,
        );
      }
      String eventIdTemp = await _eventRepository.update(event!);
      await updateAttendanceInEvent(eventIdTemp);
      //log('+++ evolutionModel');
      //log('${event!.status != null}', name: 'EvolutionModel');
      //log('$eventStatusIdPast', name: 'EvolutionModel');
      //log('${status!.id}', name: 'EvolutionModel');
      // if (event!.status != null &&
      //     eventStatusIdPast != 'turMpAqIVQ' &&
      //     status!.id == 'turMpAqIVQ') {
      //   //log('+++ evolutionModel 1 ');

      //   if (event!.professionals != null &&
      //       event!.professionals!.isNotEmpty &&
      //       event!.patients != null &&
      //       event!.patients!.isNotEmpty) {
      //     //log('+++ evolutionModel 2');

      //     for (var professional in event!.professionals!) {
      //       for (var patient in event!.patients!) {
      //         EvolutionModel evolutionModel = EvolutionModel(
      //           start: onMountDateStart(),
      //           event: eventIdTemp,
      //           professional: professional,
      //           expertise: event!.procedures![professional.id],
      //           patient: patient,
      //         );
      //         //log(evolutionModel.toString(), name: 'EvolutionModel');
      //         await _evolutionRepository.update(evolutionModel);
      //       }
      //     }
      //   }
      // }
      //log('--- evolutionModel');

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
    attendanceList.removeWhere((element) => element.id == attendanceId);
  }

  Future<void> updateAttendanceInEvent(String eventId) async {
    List<AttendanceModel> attendanceListResult = <AttendanceModel>[];
    attendanceListResult.addAll([...attendanceList]);
    for (var attendanceOriginal in attendanceListOriginal) {
      var attendanceFound = attendanceList
          .firstWhereOrNull((element) => element.id == attendanceOriginal.id);
      if (attendanceFound == null) {
        await _eventRepository.updateRelationAttendance(
            eventId, [attendanceOriginal.id!], false);
        await updateAttendanceData(attendanceOriginal.id!, false);
      } else {
        attendanceListResult
            .removeWhere((element) => element.id == attendanceFound.id);
      }
    }
    for (var attendanceResult in attendanceListResult) {
      await _eventRepository.updateRelationAttendance(
          eventId, [attendanceResult.id!], true);
      await updateAttendanceData(attendanceResult.id!, true);
    }
  }

  Future<void> updateAttendanceData(String attendanceId, bool add) async {
    if (add) {
      await _attendanceRepository.update(
        AttendanceModel(
          id: attendanceId,
          dtStartAttendance: dateStart,
          dtEndAttendance: dateEnd,
          status: eventStatusSelected,
        ),
      );
    } else {
      await _attendanceRepository.updateUnset(
          attendanceId, ['dtStartAttendance', 'dtEndAttendance', 'status']);
      await _attendanceRepository.update(
        AttendanceModel(
          id: attendanceId,
          status: EventStatusModel(id: 'uvHmcIKiFc'),
        ),
      );
    }
  }
}
