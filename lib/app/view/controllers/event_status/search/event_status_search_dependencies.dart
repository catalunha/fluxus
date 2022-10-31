import 'package:fluxus/app/data/b4a/table/event_status/event_status_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/view/controllers/event_status/search/event_status_search_controller.dart';
import 'package:get/get.dart';

class EventStatusSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventStatusRepository>(
      () => EventStatusRepositoryB4a(),
    );

    Get.put<EventStatusSearchController>(
      EventStatusSearchController(
        eventStatusRepository: Get.find(),
      ),
    );
  }
}
