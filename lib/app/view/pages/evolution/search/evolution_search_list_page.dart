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
          InkWell(
            onTap: _evolutionSearchController.lastPage
                ? null
                : () {
                    _evolutionSearchController.nextPage();
                  },
            child: Obx(() => Container(
                  color: _evolutionSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _evolutionSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
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
