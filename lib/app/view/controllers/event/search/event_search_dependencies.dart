import 'package:fluxus/app/data/b4a/table/event/event_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/view/controllers/event/search/event_search_controller.dart';
import 'package:get/get.dart';

class EventSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventRepository>(
      () => EventRepositoryB4a(),
    );
    // Get.lazyPut<HealthPlanRepository>(
    //   () => HealthPlanRepositoryB4a(),
    // );
    // Get.lazyPut<HealthPlanTypeRepository>(
    //   () => HealthPlanTypeRepositoryB4a(),
    // );

    Get.put<EventSearchController>(
      EventSearchController(
        eventRepository: Get.find(),
        // healthPlanRepository: Get.find(),
        // healthPlanTypeRepository: Get.find(),
      ),
    );
  }
}
