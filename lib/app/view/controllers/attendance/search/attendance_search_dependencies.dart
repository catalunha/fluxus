import 'package:fluxus/app/data/b4a/table/attendance/attendance_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/event_status/event_status_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/evolution/evolution_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/health_plan_type/health_plan_type_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/attendance_repository.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/data/repositories/health_plan_type_repository.dart';
import 'package:fluxus/app/view/controllers/attendance/search/attendance_search_controller.dart';
import 'package:get/get.dart';

class AttendanceSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceRepository>(
      () => AttendanceRepositoryB4a(),
    );
    Get.lazyPut<EventStatusRepository>(
      () => EventStatusRepositoryB4a(),
    );
    Get.lazyPut<EvolutionRepository>(
      () => EvolutionRepositoryB4a(),
    );
    Get.lazyPut<HealthPlanTypeRepository>(
      () => HealthPlanTypeRepositoryB4a(),
    );
    Get.put<AttendanceSearchController>(
      AttendanceSearchController(
        attendanceRepository: Get.find(),
        eventStatusRepository: Get.find(),
        evolutionRepository: Get.find(),
        healthPlanTypeRepository: Get.find(),
      ),
    );
  }
}
