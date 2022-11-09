import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final EventModel event;
  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/y hh:mm');

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   '${event.id}',
                  // ),
                  AppTextTitleValue(
                    title: 'Id: ',
                    value: event.id,
                  ),
                  AppTextTitleValue(
                    title: 'Sala: ',
                    value: event.room!.name,
                  ),
                  AppTextTitleValue(
                    title: 'Atendimento. Inicio em: ',
                    value: dateFormat.format(event.dtStart!),
                  ),
                  AppTextTitleValue(
                    title: 'Atendimento. Fim    em: ',
                    value: dateFormat.format(event.dtEnd!),
                  ),
                  AppTextTitleValue(
                    title: 'Status: ',
                    value: event.eventStatus!.name,
                  ),

                  const Text(
                    'Atendidos:',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                  attendanceList(),
                  Wrap(
                    children: [
                      // IconButton(
                      //   onPressed: () => copy(event.id!),
                      //   icon: const Icon(Icons.copy),
                      // ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.eventAddEdit, arguments: event.id);
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     // Get.toNamed(Routes.clientProfileView,
                      //     //     arguments: event.id);
                      //   },
                      //   icon: const Icon(
                      //     Icons.assignment_ind_outlined,
                      //   ),
                      // ),
                      // IconButton(
                      //   onPressed: () {
                      //     Get.toNamed(Routes.evolutionList,
                      //         arguments: event.id);
                      //   },
                      //   icon: const Icon(
                      //     Icons.people,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
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
      return Column(
        children: [
          ...event.attendance!
              .map((e) => SizedBox(
                    width: 400,
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
