import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/enums/event_status_enum.dart';
import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/attendance/search/attendance_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceCard extends StatelessWidget {
  final _attendanceSearchController = Get.find<AttendanceSearchController>();

  final AttendanceModel attendance;
  AttendanceCard({Key? key, required this.attendance}) : super(key: key);

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
                        title: 'Proc. Desc.: ',
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
                        title: 'Observação: ',
                        value: attendance.description,
                      ),
                      AppTextTitleValue(
                        title: 'Evento: ',
                        value: attendance.event,
                      ),
                      AppTextTitleValue(
                        title: 'Evolução: ',
                        value: attendance.evolution,
                      ),
                      AppTextTitleValue(
                        title: 'Data limite da autorização: ',
                        value: formatter.format(attendance.dAutorization!),
                      ),
                      AppTextTitleValue(
                        title: 'Data atendimento: ',
                        value: attendance.dtAttendance != null
                            ? formatter.format(attendance.dtAttendance!)
                            : null,
                      ),
                      // AppTextTitleValue(
                      //   title: 'Data fim atendimento: ',
                      //   value: attendance.dtEndAttendance != null
                      //       ? formatter.format(attendance.dtEndAttendance!)
                      //       : null,
                      // ),
                      Row(
                        children: [
                          AppTextTitleValue(
                              title: 'Status: ',
                              value: attendance.eventStatus?.name),
                          const SizedBox(width: 5),
                          eventStatus(attendance.eventStatus),
                        ],
                      ),
                      Row(
                        children: [
                          AppTextTitleValue(
                              title: 'Presença confirmada: ',
                              value: attendance.confirmedPresence == null
                                  ? 'Não contactado.'
                                  : attendance.confirmedPresence!
                                      ? 'SIM.'
                                      : 'Não.'),
                          const SizedBox(width: 5),
                          attendanceConfirmedPresenceIcon(
                              attendance.confirmedPresence),
                        ],
                      ),
                      Wrap(
                        spacing: 50,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await Get.toNamed(Routes.attendanceAddEdit,
                                  arguments: attendance.id!);

                              Get.back();
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => copy(attendance.id!),
                            icon: const Icon(Icons.copy),
                          ),
                          IconButton(
                            onPressed: () {
                              _attendanceSearchController
                                  .removeAttendance(attendance);
                              Get.back();
                            },
                            icon: const Icon(Icons.delete_forever),
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

  Widget eventStatus(EventStatusModel? eventStatusModel) {
    if (eventStatusModel != null) {
      if (eventStatusModel.id == EventStatusEnum.eventoAgendado.id) {
        return eventStatusIcon(eventStatusModel.name, 10, Colors.red);
      } else if (eventStatusModel.id == EventStatusEnum.eventoAtendido.id) {
        return eventStatusIcon(eventStatusModel.name, 10, Colors.yellow);
      } else if (eventStatusModel.id == EventStatusEnum.eventoFinalizado.id) {
        return eventStatusIcon(eventStatusModel.name, 10, Colors.green);
      } else {
        return eventStatusIcon(eventStatusModel.name, 10, Colors.black);
      }
    } else {
      return eventStatusIcon('Sem evento', 10, Colors.red);
    }
  }

  eventStatusIcon(String? text, double size, Color cor) {
    return Tooltip(
        message: '$text',
        child: Container(width: size, height: size, color: cor));
  }

  Widget attendanceConfirmedPresenceIcon(bool? value) {
    String text = value == null
        ? 'Presença não consultada ao paciente'
        : value
            ? 'Presença CONFIRMADA'
            : 'Paciente ausente';

    double size = 10;
    Color cor = value == null
        ? Colors.black
        : value
            ? Colors.green
            : Colors.red;

    return Tooltip(
        message: text,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
        ));
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
