import 'package:fluxus/app/data/b4a/table/event/event_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/event_status/event_status_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/evolution/evolution_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/procedure/procedure_repository_b4a.dart';
import 'package:fluxus/app/data/b4a/table/room/room_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/event_repository.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/data/repositories/procedure_repository.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:fluxus/app/view/controllers/event/addedit/event_addedit_controller.dart';
import 'package:get/get.dart';

class EventAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventRepository>(
      () => EventRepositoryB4a(),
    );
    Get.lazyPut<RoomRepository>(
      () => RoomRepositoryB4a(),
    );
    Get.lazyPut<EventStatusRepository>(
      () => EventStatusRepositoryB4a(),
    );
    Get.lazyPut<ProcedureRepository>(
      () => ProcedureRepositoryB4a(),
    );
    Get.lazyPut<EvolutionRepository>(
      () => EvolutionRepositoryB4a(),
    );
    Get.put<EventAddEditController>(
      EventAddEditController(
        eventRepository: Get.find(),
        roomRepository: Get.find(),
        eventStatusRepository: Get.find(),
        procedureRepository: Get.find(),
        evolutionRepository: Get.find(),
      ),
    );
  }
}
