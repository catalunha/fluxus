import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:fluxus/app/view/pages/evaluation/search/part/evaluation_card.dart';
import 'package:get/get.dart';

class EvaluationList extends StatelessWidget {
  final List<EvaluationModel> eventList;
  const EvaluationList({
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
          return EvaluationCard(
            evaluation: person,
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
  //           return EvaluationCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
