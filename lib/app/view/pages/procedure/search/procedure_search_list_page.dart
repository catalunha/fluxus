import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/procedure/search/procedure_search_controller.dart';
import 'package:fluxus/app/view/pages/procedure/search/part/procedure_list.dart';
import 'package:get/get.dart';

class ProcedureSearchListPage extends StatelessWidget {
  final _procedureSearchController = Get.find<ProcedureSearchController>();

  ProcedureSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_procedureSearchController.procedureList.length} procedimentos.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _procedureSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),

          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ProcedureList(
                eventList: _procedureSearchController.procedureList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
