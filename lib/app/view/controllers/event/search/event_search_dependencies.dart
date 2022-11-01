import 'package:fluxus/app/data/b4a/table/event/event_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/event_status/event_status_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/room/room_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:fluxus/app/view/controllers/event/search/event_search_controller.dart';
import 'package:get/get.dart';

class EventSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventRepository>(
      () => EventRepositoryB4a(),
    );
    Get.lazyPut<EventStatusRepository>(
      () => EventStatusRepositoryB4a(),
    );
    Get.lazyPut<RoomRepository>(
      () => RoomRepositoryB4a(),
    );

    Get.put<EventSearchController>(
      EventSearchController(
        eventRepository: Get.find(),
        eventStatusRepository: Get.find(),
        roomRepository: Get.find(),
      ),
    );
  }
}
