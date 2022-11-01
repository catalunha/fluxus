import 'package:fluxus/app/data/b4a/table/evolution/evolution_repository_b4a.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/view/controllers/evolution/search/evolution_search_controller.dart';
import 'package:get/get.dart';

class EvolutionSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvolutionRepository>(
      () => EvolutionRepositoryB4a(),
    );

    Get.put<EvolutionSearchController>(
      EvolutionSearchController(
        evolutionRepository: Get.find(),
      ),
    );
  }
}
