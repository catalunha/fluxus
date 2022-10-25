import 'package:fluxus/app/data/b4a/table/evolution/evolution_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/view/controllers/evolution/addedit/evolution_addedit_controller.dart';
import 'package:get/get.dart';

class EvolutionAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvolutionRepository>(
      () => EvolutionRepositoryB4a(),
    );

    Get.put<EvolutionAddEditController>(
      EvolutionAddEditController(
        evolutionRepository: Get.find(),
      ),
    );
  }
}
