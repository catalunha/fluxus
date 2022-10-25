import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/view/pages/evolution/search/part/evolution_card.dart';
import 'package:get/get.dart';

class EvolutionList extends StatelessWidget {
  final List<EvolutionModel> eventList;
  const EvolutionList({
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
          return EvolutionCard(
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
