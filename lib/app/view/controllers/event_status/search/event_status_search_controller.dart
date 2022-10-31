import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/data/repositories/event_status_repository.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class EventStatusSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final EventStatusRepository _eventStatusRepository;
  EventStatusSearchController({
    required EventStatusRepository eventStatusRepository,
  }) : _eventStatusRepository = eventStatusRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<EventStatusModel> eventStatusList = <EventStatusModel>[].obs;

  String? eventId;
  @override
  void onReady() {
    listAll();
    super.onReady();
  }

  @override
  void onInit() {
    eventStatusList.clear();
    loaderListener(_loading);
    messageListener(_message);
    eventId = Get.arguments;
    super.onInit();
  }

  Future<void> listAll() async {
    _loading(true);

    List<EventStatusModel> temp = await _eventStatusRepository.list();

    eventStatusList.addAll(temp);
    _loading(false);
  }
}
