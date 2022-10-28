import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/view/pages/profile/client/search/part/client_card.dart';
import 'package:get/get.dart';

class ClientProfileList extends StatelessWidget {
  final List<ProfileModel> clientProfileList;
  const ClientProfileList({
    super.key,
    required this.clientProfileList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: clientProfileList.length,
        itemBuilder: (context, index) {
          final person = clientProfileList[index];
          return ClientProfileCard(
            profile: person,
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
  //         itemCount: clientProfileList.length,
  //         itemBuilder: (context, index) {
  //           final person = clientProfileList[index];
  //           return ClientProfileCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
