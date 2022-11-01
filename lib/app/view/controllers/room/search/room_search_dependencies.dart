import 'package:fluxus/app/data/b4a/table/room/room_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:fluxus/app/view/controllers/room/search/room_search_controller.dart';
import 'package:get/get.dart';

class RoomSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomRepository>(
      () => RoomRepositoryB4a(),
    );

    Get.put<RoomSearchController>(
      RoomSearchController(
        roomRepository: Get.find(),
      ),
    );
  }
}
