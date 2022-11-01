import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/room/search/room_search_controller.dart';
import 'package:fluxus/app/view/pages/room/search/part/room_list.dart';
import 'package:get/get.dart';

class RoomSearchListPage extends StatelessWidget {
  final _roomSearchController = Get.find<RoomSearchController>();

  RoomSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text('${_roomSearchController.roomList.length} salas.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _roomSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),

          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: RoomList(
                roomList: _roomSearchController.roomList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
