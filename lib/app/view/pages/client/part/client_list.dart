import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/view/pages/client/part/client_card.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class ClientProfileList extends StatelessWidget {
  final List<ProfileModel> clientProfileList;
  final Function() nextPage;
  final bool lastPage;
  const ClientProfileList(
      {super.key,
      required this.clientProfileList,
      required this.nextPage,
      required this.lastPage});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LazyLoadScrollView(
        onEndOfPage: () => nextPage(),
        scrollOffset: 2,
        isLoading: lastPage,
        child: ListView.builder(
          itemCount: clientProfileList.length,
          itemBuilder: (context, index) {
            final person = clientProfileList[index];
            return ClientProfileCard(
              profile: person,
            );
          },
        ),
      ),
    );
  }
}
