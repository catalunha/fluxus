import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/view/pages/room/search/part/room_card.dart';
import 'package:get/get.dart';

class RoomList extends StatelessWidget {
  final List<RoomModel> roomList;
  const RoomList({
    super.key,
    required this.roomList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          final item = roomList[index];
          return RoomCard(
            room: item,
          );
        },
      ),
    );
  }
  //   @override
  // Widget build(BuildContext context) {
  //   return Obx(
  //     () => LazyLoadScrollView(
  //       onEndOfPage: () => nextPage(),
  //       scrollOffset: 2,
  //       isLoading: lastPage,
  //       child: ListView.builder(
  //         itemCount: roomList.length,
  //         itemBuilder: (context, index) {
  //           final person = roomList[index];
  //           return RoomCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
