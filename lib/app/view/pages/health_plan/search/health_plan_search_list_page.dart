import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/health_plan/search/health_plan_search_controller.dart';
import 'package:fluxus/app/view/pages/health_plan/search/part/health_plan_list.dart';
import 'package:get/get.dart';

class HealthPlanSearchListPage extends StatelessWidget {
  final _healthPlanSearchController = Get.find<HealthPlanSearchController>();

  HealthPlanSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_healthPlanSearchController.healthPlanList.length} convênios encontrados.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _healthPlanSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: HealthPlanList(
                  healthPlanList: _healthPlanSearchController.healthPlanList,
                  // nextPage: () => _healthPlanSearchController.nextPage(),
                  // lastPage: _healthPlanSearchController.lastPage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
