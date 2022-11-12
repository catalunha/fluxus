import 'package:fluxus/app/data/b4a/table/event_status/event_status_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/expect/expect_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/expertise/expertise_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/expect_repository.dart';
import 'package:fluxus/app/data/repositories/expertise_repository.dart';
import 'package:fluxus/app/view/controllers/expect/search/expect_search_controller.dart';
import 'package:get/get.dart';

class ExpectSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpectRepository>(
      () => ExpectRepositoryB4a(),
    );
    Get.lazyPut<EventStatusRepository>(
      () => EventStatusRepositoryB4a(),
    );
    Get.lazyPut<ExpertiseRepository>(
      () => ExpertiseRepositoryB4a(),
    );

    Get.put<ExpectSearchController>(
      ExpectSearchController(
        expectRepository: Get.find(),
        eventStatusRepository: Get.find(),
        expertiseRepository: Get.find(),
      ),
    );
  }
}
