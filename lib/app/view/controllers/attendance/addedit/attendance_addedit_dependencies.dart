import 'package:fluxus/app/data/b4a/table/attendance/attendance_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/attendance_repository.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/attendance/addedit/attendance_addedit_controller.dart';
import 'package:get/get.dart';

class AttendanceAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendanceRepository>(
      () => AttendanceRepositoryB4a(),
    );

    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryB4a(),
    );
    // Get.lazyPut<ProcedureRepository>(
    //   () => ProcedureRepositoryB4a(),
    // );
    // Get.lazyPut<EvolutionRepository>(
    //   () => EvolutionRepositoryB4a(),
    // );
    Get.put<AttendanceAddEditController>(
      AttendanceAddEditController(
        attendanceRepository: Get.find(),
        profileRepository: Get.find(),
      ),
    );
  }
}
