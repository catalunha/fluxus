import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/data/repositories/evolution_repository.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class EvolutionSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final EvolutionRepository _evaluationRepository;
  EvolutionSearchController({
    required EvolutionRepository evaluationRepository,
  }) : _evaluationRepository = evaluationRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<EvolutionModel> evaluationList = <EvolutionModel>[].obs;

  String? eventId;
  @override
  void onReady() {
    listAll();
    super.onReady();
  }

  @override
  void onInit() {
    evaluationList.clear();
    loaderListener(_loading);
    messageListener(_message);
    eventId = Get.arguments;
    super.onInit();
  }

  Future<void> listAll() async {
    _loading(true);

    var splashController = Get.find<SplashController>();
    String professionalId = splashController.userModel!.profile!.id!;
    List<EvolutionModel> temp =
        await _evaluationRepository.list(eventId!, professionalId);

    evaluationList.addAll(temp);
    _loading(false);
  }
}
