// import 'package:flutter/material.dart';
// import 'package:fluxus/app/view/controllers/client/search/client_search_controller.dart';
// import 'package:fluxus/app/view/pages/client/search/part/client_list.dart';
// import 'package:get/get.dart';

// class ClientSearchListPage extends StatelessWidget {
//   final _clientProfileController = Get.find<ClientSearchController>();

//   ClientSearchListPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(
//           () => Text(
//               '${_clientProfileController.clientProfileList.length} pacientes encontrados.'),
//         ),
//       ),
//       body: Column(
//         children: [
//           Obx(() => Divider(
//                 color: _clientProfileController.lastPage
//                     ? Colors.red
//                     : Colors.green,
//               )),
//           Expanded(
//             child: Obx(() => ClientProfileList(
//                   clientProfileList: _clientProfileController.clientProfileList,
//                   nextPage: () => _clientProfileController.nextPage(),
//                   lastPage: _clientProfileController.lastPage,
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
