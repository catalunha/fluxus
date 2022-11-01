import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/data/repositories/room_repository.dart';
import 'package:fluxus/app/view/controllers/utils/loader_mixin.dart';
import 'package:fluxus/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class RoomSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final RoomRepository _roomRepository;
  RoomSearchController({
    required RoomRepository roomRepository,
  }) : _roomRepository = roomRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<RoomModel> roomList = <RoomModel>[].obs;

  @override
  void onReady() {
    listAll();
    super.onReady();
  }

  @override
  void onInit() {
    roomList.clear();
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<void> listAll() async {
    _loading(true);

    List<RoomModel> temp = await _roomRepository.list();

    roomList.addAll(temp);
    _loading(false);
  }
}
