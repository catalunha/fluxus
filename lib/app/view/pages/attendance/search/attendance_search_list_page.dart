import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/attendance/search/attendance_search_controller.dart';
import 'package:fluxus/app/view/pages/attendance/search/part/attendance_list.dart';
import 'package:get/get.dart';

class AttendanceSearchListPage extends StatelessWidget {
  final _attendanceSearchController = Get.find<AttendanceSearchController>();

  AttendanceSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              '${_attendanceSearchController.attendanceList.length} guias encontrados.'),
        ),
      ),
      body: Column(
        children: [
          // Obx(() => Divider(
          //       color: _attendanceSearchController.lastPage
          //           ? Colors.red
          //           : Colors.green,
          //     )),
          InkWell(
            onTap: () {
              _attendanceSearchController.nextPage();
            },
            child: Obx(() => Container(
                  color: _attendanceSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _attendanceSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: AttendanceList(
                attendanceList: _attendanceSearchController.attendanceList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
