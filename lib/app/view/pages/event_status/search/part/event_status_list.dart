import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/view/pages/event_status/search/part/event_status_card.dart';
import 'package:get/get.dart';

class EventStatusList extends StatelessWidget {
  final List<EventStatusModel> eventStatusList;
  const EventStatusList({
    super.key,
    required this.eventStatusList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: eventStatusList.length,
        itemBuilder: (context, index) {
          final person = eventStatusList[index];
          return EventStatusCard(
            eventStatus: person,
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
  //         itemCount: eventStatusList.length,
  //         itemBuilder: (context, index) {
  //           final person = eventStatusList[index];
  //           return EventStatusCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
