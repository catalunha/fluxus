import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/data/b4a/entity/attendance_entity.dart';
import 'package:fluxus/app/data/b4a/entity/event_status_entity.dart';
import 'package:fluxus/app/data/b4a/entity/procedure_entity.dart';
import 'package:fluxus/app/data/b4a/entity/profile_entity.dart';
import 'package:fluxus/app/data/repositories/attendance_repository.dart';
import 'package:fluxus/app/data/utils/pagination.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AttendanceSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final AttendanceRepository _attendanceRepository;
  AttendanceSearchController({
    required AttendanceRepository attendanceRepository,
  }) : _attendanceRepository = attendanceRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  final Rxn<DateTime> _dAutorization = Rxn<DateTime>();
  DateTime? get dAutorization => _dAutorization.value;
  set dAutorization(DateTime? dAutorization1) {
    _dAutorization.value = dAutorization1;
  }

  final Rxn<DateTime> _dAttendance = Rxn<DateTime>();
  DateTime? get dAttendance => _dAttendance.value;
  set dAttendance(DateTime? dAttendance1) {
    _dAttendance.value = dAttendance1;
  }

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ProfileEntity.className));
  @override
  void onInit() {
    attendanceList.clear();
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
    required bool professionalEqualToBool,
    required String professionalEqualToString,
    required bool patientEqualToBool,
    required String patientEqualToString,
    required bool procedureEqualToBool,
    required String procedureEqualToString,
    required bool eventStatusEqualToBool,
    required String eventStatusEqualToString,
    required bool autorizationEqualToBool,
    required String autorizationEqualToString,
    required bool eventEqualToBool,
    required String eventEqualToString,
    required bool dAutorizationBool,
    required bool dAttendanceBool,
  }) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(AttendanceEntity.className));
    if (professionalEqualToBool) {
      query.whereEqualTo(
          'professional',
          (ParseObject(ProfileEntity.className)
                ..objectId = professionalEqualToString)
              .toPointer());
    }
    if (patientEqualToBool) {
      query.whereEqualTo(
          'patient',
          (ParseObject(ProfileEntity.className)
                ..objectId = patientEqualToString)
              .toPointer());
    }
    if (procedureEqualToBool) {
      query.whereEqualTo(
          'procedure',
          (ParseObject(ProcedureEntity.className)
                ..objectId = procedureEqualToString)
              .toPointer());
    }
    if (eventStatusEqualToBool) {
      query.whereEqualTo(
          'eventStatus',
          (ParseObject(EventStatusEntity.className)
                ..objectId = eventStatusEqualToString)
              .toPointer());
    }
    if (dAutorizationBool && dAutorization != null) {
      query.whereEqualTo('dAutorization', dAutorization);
      // query.whereGreaterThanOrEqualsTo(
      //     'dAutorization',
      //     DateTime(
      //         dAutorization!.year, dAutorization!.month, dAutorization!.day));
      // query.whereLessThanOrEqualTo(
      //     'dAutorization',
      //     DateTime(dAutorization!.year, dAutorization!.month,
      //         dAutorization!.day, 23, 59));
    }
    if (dAttendanceBool && dAttendance != null) {
      query.whereGreaterThanOrEqualsTo('dAttendance',
          DateTime(dAttendance!.year, dAttendance!.month, dAttendance!.day));
      query.whereLessThanOrEqualTo(
          'dAttendance',
          DateTime(
              dAttendance!.year, dAttendance!.month, dAttendance!.day, 23, 59));
    }
    if (autorizationEqualToBool) {
      query.whereEqualTo('autorization', autorizationEqualToString);
    }
    if (eventEqualToBool) {
      query.whereEqualTo('event', eventEqualToString);
    }
    attendanceList.clear();
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
    Get.toNamed(Routes.attendanceList);
  }

  Future<void> listAll() async {
    if (!lastPage) {
      _loading(true);
      List<AttendanceModel> temp =
          await _attendanceRepository.list(query, _pagination.value);
      if (temp.isEmpty) {
        _lastPage.value = true;
      }
      attendanceList.addAll(temp);
      _loading(false);
    }
  }
}
