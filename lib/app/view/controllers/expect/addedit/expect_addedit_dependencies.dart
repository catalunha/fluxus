import 'package:fluxus/app/data/b4a/table/event_status/event_status_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/expect/expect_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/expertise/expertise_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/profile/profile_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/expect_repository.dart';
import 'package:fluxus/app/data/repositories/expertise_repository.dart';
import 'package:fluxus/app/data/repositories/profile_repository.dart';
import 'package:fluxus/app/view/controllers/expect/addedit/expect_addedit_controller.dart';
import 'package:get/get.dart';

class ExpectAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpectRepository>(
      () => ExpectRepositoryB4a(),
    );

    Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryB4a(),
    );

    Get.lazyPut<ExpertiseRepository>(
      () => ExpertiseRepositoryB4a(),
    );
    Get.lazyPut<EventStatusRepository>(
      () => EventStatusRepositoryB4a(),
    );
    Get.put<ExpectAddEditController>(
      ExpectAddEditController(
        expectRepository: Get.find(),
        profileRepository: Get.find(),
        eventStatusRepository: Get.find(),
        expertiseRepository: Get.find(),
      ),
    );
  }
}
