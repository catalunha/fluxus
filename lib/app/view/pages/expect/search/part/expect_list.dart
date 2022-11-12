import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/expect_model.dart';
import 'package:fluxus/app/view/pages/expect/search/part/expect_card.dart';
import 'package:get/get.dart';

class ExpectList extends StatelessWidget {
  final List<ExpectModel> expectList;
  const ExpectList({
    super.key,
    required this.expectList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: expectList.length,
        itemBuilder: (context, index) {
          final person = expectList[index];
          return ExpectCard(
            expect: person,
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
  //         itemCount: expectList.length,
  //         itemBuilder: (context, index) {
  //           final person = expectList[index];
  //           return ExpectCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
