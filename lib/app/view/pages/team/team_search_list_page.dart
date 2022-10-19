import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/team/search/team_search_controller.dart';
import 'package:fluxus/app/view/pages/team/part/team_list.dart';
import 'package:get/get.dart';

class TeamSearchListPage extends StatelessWidget {
  final _teamSearchController = Get.find<TeamSearchController>();

  TeamSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_teamSearchController.teamProfileList.length} profissionais.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _teamSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),
          InkWell(
            onTap: () {
              _teamSearchController.nextPage();
            },
            child: Obx(() => Container(
                  color: _teamSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _teamSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: TeamProfileList(
                clientProfileList: _teamSearchController.teamProfileList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
