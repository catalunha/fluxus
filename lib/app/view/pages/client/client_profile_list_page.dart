import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/client/client_profile_controller.dart';
import 'package:fluxus/app/view/pages/client/part/client_profile_list.dart';
import 'package:get/get.dart';

class ClientProfileListPage extends StatelessWidget {
  final _clientProfileController = Get.find<ClientProfileController>();

  ClientProfileListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista dos Pacientes'),
      ),
      body: Column(
        children: [
          Obx(() => Divider(
                color: _clientProfileController.lastPage
                    ? Colors.red
                    : Colors.green,
              )),
          Expanded(
            child: Obx(() => ClientProfileList(
                  clientProfileList: _clientProfileController.clientProfileList,
                  nextPage: () => _clientProfileController.nextPage(),
                  lastPage: _clientProfileController.lastPage,
                )),
          ),
        ],
      ),
    );
  }
}
