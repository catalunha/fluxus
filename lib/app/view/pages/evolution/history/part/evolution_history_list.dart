import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/view/pages/evolution/history/part/evolution_history_card.dart';
import 'package:get/get.dart';

class EvolutionHistoryList extends StatelessWidget {
  final List<EvolutionModel> eventList;
  const EvolutionHistoryList({
    super.key,
    required this.eventList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          final person = eventList[index];
          return EvolutionHistoryCard(
            evolution: person,
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
  //         itemCount: eventList.length,
  //         itemBuilder: (context, index) {
  //           final person = eventList[index];
  //           return EvolutionCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
