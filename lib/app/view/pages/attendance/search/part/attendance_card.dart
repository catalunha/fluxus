import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final AttendanceModel attendance;
  const AttendanceCard({Key? key, required this.attendance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextTitleValue(
                        title: 'Id: ',
                        value: attendance.id,
                      ),
                      AppTextTitleValue(
                        title: 'Prof.: ',
                        value: attendance.professional!.name,
                      ),
                      AppTextTitleValue(
                        title: 'Proc. code: ',
                        value: attendance.procedure!.code,
                      ),
                      AppTextTitleValue(
                        title: 'Proc.: ',
                        value: attendance.procedure!.name,
                      ),
                      AppTextTitleValue(
                        title: 'Paciente: ',
                        value: attendance.patient!.name,
                      ),
                      AppTextTitleValue(
                        title: 'Conv. code: ',
                        value: attendance.healthPlan!.code,
                      ),
                      AppTextTitleValue(
                        title: 'Conv. nome: ',
                        value: attendance.healthPlan!.healthPlanType?.name,
                      ),
                      AppTextTitleValue(
                        title: 'Autorização: ',
                        value: attendance.autorization,
                      ),
                      AppTextTitleValue(
                        title: 'Data Autorização: ',
                        value: formatter.format(attendance.dAutorization!),
                      ),
                      AppTextTitleValue(
                        title: 'Data atendimento: ',
                        value: attendance.dAttendance != null
                            ? formatter.format(attendance.dAttendance!)
                            : null,
                      ),
                      // AppTextTitleValue(
                      //   title: 'Data fim atendimento: ',
                      //   value: attendance.dtEndAttendance != null
                      //       ? formatter.format(attendance.dtEndAttendance!)
                      //       : null,
                      // ),
                      AppTextTitleValue(
                          title: 'Status: ',
                          value: attendance.eventStatus?.name),
                      Wrap(
                        children: [
                          IconButton(
                            onPressed: () => copy(attendance.id!),
                            icon: const Icon(Icons.copy),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(
      text, 'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 1),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
