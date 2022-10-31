import 'package:fluxus/app/core/models/procedure_model.dart';
import 'package:fluxus/app/data/repositories/procedure_repository.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class ProcedureSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final ProcedureRepository _evaluationRepository;
  ProcedureSearchController({
    required ProcedureRepository evaluationRepository,
  }) : _evaluationRepository = evaluationRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ProcedureModel> procedureList = <ProcedureModel>[].obs;

  String? eventId;
  @override
  void onReady() {
    listAll();
    super.onReady();
  }

  @override
  void onInit() {
    procedureList.clear();
    loaderListener(_loading);
    messageListener(_message);
    eventId = Get.arguments;
    super.onInit();
  }

  Future<void> listAll() async {
    _loading(true);

    List<ProcedureModel> temp = await _evaluationRepository.list();

    procedureList.addAll(temp);
    _loading(false);
  }
}
