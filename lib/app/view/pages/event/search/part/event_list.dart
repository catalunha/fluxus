import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/view/pages/event/search/part/event_card.dart';
import 'package:get/get.dart';

class EventList extends StatelessWidget {
  final List<EventModel> eventList;
  const EventList({
    super.key,
    required this.eventList,
  });

  @override
  Widget build(BuildContext context) {
    List<DateTime> dates = [];
    return Obx(
      () => ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          final event = eventList[index];
          if (dates.contains(event.dtStart)) {
            return EventCard(
              event: event,
              withDateStart: false,
            );
          } else {
            dates.add(event.dtStart!);
            return EventCard(
              event: event,
              withDateStart: true,
            );
          }
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
  //         itemCount: eventList.length,
  //         itemBuilder: (context, index) {
  //           final person = eventList[index];
  //           return EventCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
