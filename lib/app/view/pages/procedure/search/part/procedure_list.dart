import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/procedure_model.dart';
import 'package:fluxus/app/view/pages/procedure/search/part/procedure_card.dart';
import 'package:get/get.dart';

class ProcedureList extends StatelessWidget {
  final List<ProcedureModel> eventList;
  const ProcedureList({
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
          return ProcedureCard(
            procedure: person,
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
  //           return ProcedureCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
