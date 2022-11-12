import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/expect/search/expect_search_controller.dart';
import 'package:fluxus/app/view/pages/expect/search/part/expect_list.dart';
import 'package:get/get.dart';

class ExpectSearchListPage extends StatelessWidget {
  final _expectSearchController = Get.find<ExpectSearchController>();

  ExpectSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_expectSearchController.expectList.length} esperas encontradas.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _expectSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),
          InkWell(
            onTap: () {
              _expectSearchController.nextPage();
            },
            child: Obx(() => Container(
                  color: _expectSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _expectSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ExpectList(
                expectList: _expectSearchController.expectList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
