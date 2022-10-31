import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/event_status/search/event_status_search_controller.dart';
import 'package:fluxus/app/view/pages/event_status/search/part/event_status_list.dart';
import 'package:get/get.dart';

class EventStatusSearchListPage extends StatelessWidget {
  final _eventStatusSearchController = Get.find<EventStatusSearchController>();

  EventStatusSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_eventStatusSearchController.eventStatusList.length} status de eventos.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _eventStatusSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),

          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: EventStatusList(
                eventStatusList: _eventStatusSearchController.eventStatusList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
