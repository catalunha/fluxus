import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/view/pages/health_plan/search/part/health_plan_card.dart';
import 'package:get/get.dart';

class HealthPlanList extends StatelessWidget {
  final List<HealthPlanModel> healthPlanList;
  // final Function() nextPage;
  // final bool lastPage;
  const HealthPlanList({
    super.key,
    required this.healthPlanList,
    // required this.nextPage,
    // required this.lastPage,
  });
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: healthPlanList.length,
        itemBuilder: (context, index) {
          final healthPlan = healthPlanList[index];
          return HealthPlanCard(
            healthPlanModel: healthPlan,
          );
        },
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Obx(
  //     () => LazyLoadScrollView(
  //       onEndOfPage: () => nextPage(),
  //       scrollOffset: 2,
  //       isLoading: lastPage,
  //       child: ListView.builder(
  //         itemCount: healthPlanList.length,
  //         itemBuilder: (context, index) {
  //           final person = healthPlanList[index];
  //           return HealthPlanCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
