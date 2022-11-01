import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/evolution/search/evolution_search_controller.dart';
import 'package:fluxus/app/view/pages/evolution/search/part/evolution_list.dart';
import 'package:get/get.dart';

class EvolutionSearchListPage extends StatelessWidget {
  final _evolutionSearchController = Get.find<EvolutionSearchController>();

  EvolutionSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_evolutionSearchController.evolutionList.length} evoluções.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _evolutionSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),

          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: EvolutionList(
                eventList: _evolutionSearchController.evolutionList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
