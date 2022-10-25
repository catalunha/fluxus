import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/evaluation/search/evaluation_search_controller.dart';
import 'package:fluxus/app/view/pages/evaluation/search/part/evaluation_list.dart';
import 'package:get/get.dart';

class EvaluationSearchListPage extends StatelessWidget {
  final _evaluationSearchController = Get.find<EvaluationSearchController>();

  EvaluationSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_evaluationSearchController.evaluationList.length} fichas encontradas.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _evaluationSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),
          InkWell(
            onTap: () {
              _evaluationSearchController.nextPage();
            },
            child: Obx(() => Container(
                  color: _evaluationSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _evaluationSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: EvaluationList(
                eventList: _evaluationSearchController.evaluationList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
