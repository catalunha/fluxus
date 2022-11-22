import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/enums/expertise_enum.dart';
import 'package:fluxus/app/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:fluxus/app/core/enums/event_status_enum.dart';
import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';

class EventCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final EventModel event;
  final bool withDateStart;
  const EventCard({
    Key? key,
    required this.event,
    required this.withDateStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM');
    final timeFormat = DateFormat('hh:mm');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        child: Row(
          children: [
            withDateStart
                ? SizedBox(
                    width: 50, child: Text(dateFormat.format(event.dtStart!)))
                : const SizedBox(
                    width: 50,
                  ),
            const SizedBox(width: 5),
            Text(
                '${timeFormat.format(event.dtStart!)} - ${timeFormat.format(event.dtEnd!)}'),
            const SizedBox(width: 5),
            eventStatus(event.eventStatus),
            const SizedBox(width: 5),
            Text('${event.room?.code}'),
            const SizedBox(width: 5),
            attendanceList(),
            const SizedBox(width: 5),
            Tooltip(
              message: '${event.id}',
              child: InkWell(
                  onTap: () async {
                    await Get.toNamed(Routes.eventAddEdit, arguments: event.id);
                    Get.back();
                  },
                  child: const Icon(Icons.edit, size: 16)),
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

  confirmedPresenceIcon(String? text, double size, Color cor) {
    return Tooltip(
        message: '$text',
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
      text,
      'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }

  Widget attendanceList() {
    if (event.attendance != null && event.attendance!.isNotEmpty) {
      List<Widget> itens = [];
      for (var attendance in event.attendance!) {
        itens.add(Row(
          children: [
            confirmedPresenceIcon(
                attendance.confirmedPresence == null
                    ? 'Presença não consultada ao paciente'
                    : attendance.confirmedPresence!
                        ? 'Presença CONFIRMADA'
                        : 'Paciente ausente',
                10,
                attendance.confirmedPresence == null
                    ? Colors.black
                    : attendance.confirmedPresence!
                        ? Colors.green
                        : Colors.red),
            const SizedBox(width: 5),
            Tooltip(
              message: '${attendance.patient!.name}',
              child: SizedBox(
                width: 125,
                child: Text(
                  attendance.patient!.name!.substring(0, 15),
                ),
              ),
            ),
            const Text(' - '),
            Tooltip(
                message: '${attendance.professional!.name}',
                child: SizedBox(
                    width: 50,
                    child:
                        Text(attendance.professional!.name!.substring(0, 5)))),
            const Text(' - '),
            Container(
              // width: 40,
              color: expertiseColor(attendance.procedure!.expertise!.id!),
              child: Tooltip(
                  message: attendance.procedure!.name!,
                  child: Text(attendance.procedure!.code!)),
            ),
          ],
        ));
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: itens,
      );
    } else {
      return Container(
        color: Colors.blue,
      );
    }
  }

  Color expertiseColor(String expertiseId) {
    if (ExpertiseEnum.psicologia.id == expertiseId) {
      return ExpertiseEnum.psicologia.cor;
    } else if (ExpertiseEnum.enfermeira.id == expertiseId) {
      return ExpertiseEnum.enfermeira.cor;
    } else if (ExpertiseEnum.fonoaudiologia.id == expertiseId) {
      return ExpertiseEnum.fonoaudiologia.cor;
    }
    return Colors.black;
  }

  Widget attendanceList1() {
    if (event.attendance != null && event.attendance!.isNotEmpty) {
      return Column(
        children: [
          ...event.attendance!
              .map((e) => SizedBox(
                    width: 300,
                    child: Card(
                      color: Colors.black12,
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // AppTextTitleValue(
                                  //   title: 'Atendimento Id: ',
                                  //   value: '${e.id}',
                                  // ),
                                  AppTextTitleValue(
                                    title: 'Paciente: ',
                                    value: '${e.patient!.name}',
                                  ),
                                  // AppTextTitleValue(
                                  //   title: 'Id: ',
                                  //   value: '${e.patient!.id}',
                                  // ),
                                  AppTextTitleValue(
                                    title: 'Profissional: ',
                                    value: '${e.professional!.name}',
                                  ),
                                  // AppTextTitleValue(
                                  //   title: 'Id: ',
                                  //   value: '${e.professional!.id}',
                                  // ),
                                  AppTextTitleValue(
                                    title: 'Procedimento: ',
                                    value: '${e.procedure!.name}',
                                  ),
                                  AppTextTitleValue(
                                    title: 'Observações: ',
                                    value: '${e.description}',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ))
              .toList()
        ],
      );
    } else {
      return Container(
        color: Colors.blue,
      );
    }
  }
}
