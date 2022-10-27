// import 'package:flutter/material.dart';
// import 'package:fluxus/app/view/controllers/event/search/event_search_controller.dart';
// import 'package:fluxus/app/view/pages/event/search/part/event_list.dart';
// import 'package:get/get.dart';

// class EventSearchListPage extends StatelessWidget {
//   final _clientProfileController = Get.find<EventSearchController>();

//   EventSearchListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(
//           () => Text(
//               '${_clientProfileController.eventList.length} eventos encontrados.'),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Obx(() => Divider(
//           //       color: _clientProfileController.lastPage
//           //           ? Colors.red
//           //           : Colors.green,
//           //     )),
//           InkWell(
//             onTap: () {
//               _clientProfileController.nextPage();
//             },
//             child: Obx(() => Container(
//                   color: _clientProfileController.lastPage
//                       ? Colors.black
//                       : Colors.green,
//                   height: 24,
//                   child: Center(
//                     child: _clientProfileController.lastPage
//                         ? const Text('Última página')
//                         : const Text('Próxima página'),
//                   ),
//                 )),
//           ),
//           Expanded(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 600),
//               child: EventList(
//                 eventList: _clientProfileController.eventList,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
