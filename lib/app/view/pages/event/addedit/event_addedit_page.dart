import 'package:flutter/material.dart';
import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/core/utils/allowed_access.dart';
import 'package:fluxus/app/core/utils/start_date_drop_down.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/event/addedit/event_addedit_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_dialog_add_ids.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class EventAddEditPage extends StatefulWidget {
  final _eventAddEditController = Get.find<EventAddEditController>();
  EventAddEditPage({Key? key}) : super(key: key);

  @override
  State<EventAddEditPage> createState() => _EventAddEditPageState();
}

class _EventAddEditPageState extends State<EventAddEditPage> {
  final dateFormat = DateFormat('dd/MM/y');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar evento'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveEvent();
          if (result) {
            Get.back();
          } else {
            Get.snackbar(
              'Atenção',
              'Campos obrigatórios não foram preenchidos.',
              backgroundColor: Colors.red,
            );
          }
        },
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 5),

                    Obx(() => AppTextTitleValue(
                          title: 'Id: ',
                          value: widget._eventAddEditController.event?.id,
                        )),
                    dateStart(),
                    timeStart(),
                    room(),
                    const SizedBox(height: 10),
                    attendance(context),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     IconButton(
                    //         onPressed: () {
                    //           Get.toNamed(Routes.clientProfileSearch);
                    //         },
                    //         icon: const Icon(Icons.search)),
                    //     const Text('Pacientes'),
                    //     IconButton(
                    //       onPressed: () async {
                    //         var result = await saveEvent();
                    //         if (result) {
                    //           String? res = await showDialog(
                    //             barrierDismissible: false,
                    //             context: context,
                    //             builder: (BuildContext context) {
                    //               return const EventAddIds(
                    //                 title:
                    //                     'Informe o Id do paciente e do convênio',
                    //               );
                    //             },
                    //           );
                    //           if (res != null) {
                    //             widget._eventAddEditController
                    //                 .updatePatients(ids: res, add: true);
                    //           }
                    //           log(res ?? '...', name: 'res');
                    //           setState(() {});
                    //         } else {
                    //           Get.snackbar(
                    //             'Atenção',
                    //             'Campos obrigatórios não foram preenchidos.',
                    //             backgroundColor: Colors.red,
                    //           );
                    //         }
                    //       },
                    //       icon: const Icon(Icons.add),
                    //     )
                    //   ],
                    // ),
                    // Obx(() => patientList()),
                    Column(
                      children: [
                        const Text('* Status do evento'),
                        Obx(
                          () => AppDropDownGeneric<EventStatusModel>(
                            options: widget
                                ._eventAddEditController.eventStatusList
                                .toList(),
                            selected: widget
                                ._eventAddEditController.eventStatusSelected,
                            execute: (value) {
                              widget._eventAddEditController
                                  .eventStatusSelected = value;
                              print(value);
                              print(widget
                                  ._eventAddEditController.eventStatusSelected);
                              setState(() {});
                            },
                            width: double.maxFinite,
                          ),
                        ),
                      ],
                    ),

                    AppTextFormField(
                      label: 'Descrição',
                      controller: widget._eventAddEditController.descriptionTec,
                      maxLines: 3,
                    ),
                    const Text('Descrições anteriores:'),
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Obx(() => Text(
                              widget._eventAddEditController.event?.log ?? '',
                            )),
                      ),
                    ),

                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget attendance(BuildContext context) {
    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id])) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.attendanceSearch);
                  },
                  icon: const Icon(Icons.search)),
              const Text('* Atendimentos'),
              IconButton(
                onPressed: () async {
                  // var result = await saveEvent();
                  // if (result) {
                  String? res = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const AppDialogAddIds(
                        title: 'Informe o Id do atendimento',
                      );
                    },
                  );
                  if (res != null) {
                    await widget._eventAddEditController.addAttendance(res);
                  }
                  setState(() {});
                  // } else {
                  //   Get.snackbar(
                  //     'Atenção',
                  //     'Campos obrigatórios não foram preenchidos.',
                  //     backgroundColor: Colors.red,
                  //   );
                  // }
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          Obx(() => attendanceList()),
        ],
      );
    } else {
      return Column(
        children: [
          const AppTextTitleValue(
            title: 'Atendimentos: ',
            value: '',
          ),
          Obx(() => attendanceList2()),
        ],
      );
    }
  }

  Widget room() {
    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id])) {
      return Column(
        children: [
          const Text('Ambiente'),
          Obx(
            () => AppDropDownGeneric<RoomModel>(
              options: widget._eventAddEditController.roomList.toList(),
              selected: widget._eventAddEditController.roomModelSelected,
              execute: (value) {
                widget._eventAddEditController.roomModelSelected = value;
                setState(() {});
              },
              width: double.maxFinite,
            ),
          ),
        ],
      );
    } else {
      return Obx(() => AppTextTitleValue(
            title: 'Sala: ',
            value: widget._eventAddEditController.roomModelSelected?.name,
          ));
    }
  }

  Widget timeStart() {
    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id])) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Text('Início'),
              Obx(() => AppDropDownGeneric<StartDateDropDrow>(
                    options:
                        widget._eventAddEditController.startDateList.toList(),
                    selected: widget
                        ._eventAddEditController.startDateDropDrowSelected,
                    execute: (value) {
                      widget._eventAddEditController.startDateDropDrowSelected =
                          value;
                      widget._eventAddEditController
                          .onUpdateStartChangeEnd(value!);
                      setState(() {});
                    },
                    width: 150,
                  )),
            ],
          ),
          Column(
            children: [
              const Text('Fim'),
              Obx(
                () => AppDropDownGeneric<StartDateDropDrow>(
                  options:
                      widget._eventAddEditController.startDateList.toList(),
                  selected:
                      widget._eventAddEditController.endDateDropDrowSelected,
                  execute: (value) {
                    widget._eventAddEditController.endDateDropDrowSelected =
                        value;
                    widget._eventAddEditController.onUpdateEnd(value!);
                    setState(() {});
                  },
                  width: 150,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Obx(() => AppTextTitleValue(
            title: 'Horário: ',
            value:
                '${widget._eventAddEditController.startDateDropDrowSelected?.name} as ${widget._eventAddEditController.endDateDropDrowSelected?.name}',
          ));
    }
  }

  Widget dateStart() {
    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id])) {
      return AppCalendarButton(
        title: "Data do atendimento.",
        getDate: () => widget._eventAddEditController.dateStart,
        setDate: (value) => widget._eventAddEditController.dateStart = value,
        isBirthDay: false,
      );
    } else {
      return Obx(() => AppTextTitleValue(
          title: 'Data do atendimento: ',
          value: widget._eventAddEditController.dateStart != null
              ? dateFormat.format(widget._eventAddEditController.dateStart!)
              : ''));
    }
  }

  Future<bool> saveEvent() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      if (widget._eventAddEditController.dateStart == null) {
        return false;
      }
      if (widget._eventAddEditController.eventStatusSelected == null) {
        return false;
      }
      if (widget._eventAddEditController.startDateDropDrowSelected == null) {
        return false;
      }
      if (widget._eventAddEditController.endDateDropDrowSelected == null) {
        return false;
      }
      if (widget._eventAddEditController.attendanceList.isEmpty) {
        return false;
      }
      await widget._eventAddEditController.append(
        room: widget._eventAddEditController.roomModelSelected,
        status: widget._eventAddEditController.eventStatusSelected,
        description: widget._eventAddEditController.descriptionTec.text,
      );
      return true;
    }
    return false;
  }

  Widget attendanceList() {
    if (widget._eventAddEditController.attendanceList.isNotEmpty) {
      return Column(
        children: [
          ...widget._eventAddEditController.attendanceList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              confirmedPresence(e.id!),
                              const SizedBox(height: 50),
                              InkWell(
                                onLongPress: () async {
                                  // await saveEvent();
                                  await widget._eventAddEditController
                                      .removeAttendance(e.id!);
                                  setState(() {});
                                },
                                child: const Icon(Icons.delete_forever),
                              ),
                            ],
                          ),
                          attendanceData(e)
                        ],
                      ),
                    ]),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }

  Widget confirmedPresence(String attendanceId) {
    Widget icon;
    if (widget._eventAddEditController
            .attendanceConfirmedPresence[attendanceId] ==
        true) {
      icon = Tooltip(
        message: 'Presença CONFIRMADA',
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
      );
    } else if (widget._eventAddEditController
            .attendanceConfirmedPresence[attendanceId] ==
        false) {
      icon = Tooltip(
        message: 'Paciente ausente',
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      );
    } else {
      icon = Tooltip(
        message: 'Sem contato com paciente',
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return InkWell(
      child: icon,
      onTap: () => widget._eventAddEditController
          .updateAttendanceConfirmedPresence(attendanceId),
    );

    return Text(
        '${widget._eventAddEditController.attendanceConfirmedPresence[attendanceId]}');
  }

  Widget attendanceList2() {
    if (widget._eventAddEditController.attendanceList.isNotEmpty) {
      return Column(
        children: [
          ...widget._eventAddEditController.attendanceList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          // IconButton(
                          //   onPressed: () async {
                          //     // await widget._eventAddEditController
                          //     //     .removeAttendance(e.id!);
                          //     // setState(() {});
                          //   },
                          //   icon: const Icon(Icons.person_off),
                          // ),
                          attendanceData(e)
                        ],
                      ),
                    ]),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }

  Expanded attendanceData(AttendanceModel e) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextTitleValue(
            title: 'attendanceId: ',
            value: '${e.id}',
          ),
          AppTextTitleValue(
            title: 'Pac. Nome: ',
            value: '${e.patient!.name}',
          ),
          AppTextTitleValue(
            title: 'patientId: ',
            value: '${e.patient!.id}',
          ),
          AppTextTitleValue(
            title: 'Prof. Nome: ',
            value: '${e.professional!.name}',
          ),
          AppTextTitleValue(
            title: 'professionalId: ',
            value: '${e.professional!.id}',
          ),
          AppTextTitleValue(
            title: 'Procedimento. Cod.: ',
            value: '${e.procedure!.code}',
          ),
          AppTextTitleValue(
            title: 'Procedimento. Nome: ',
            value: '${e.procedure!.name}',
          ),
          AppTextTitleValue(
            title: 'Descrição: ',
            value: '${e.description}',
          ),
        ],
      ),
    );
  }

  // Widget profissionalList() {
  //   if (widget._eventAddEditController.event?.professionals != null) {
  //     return Column(
  //       children: [
  //         ...widget._eventAddEditController.event!.professionals!
  //             .map((e) => Card(
  //                   child: Column(children: [
  //                     Row(
  //                       children: [
  //                         IconButton(
  //                           onPressed: () async {
  //                             // await saveEvent();
  //                             await widget._eventAddEditController
  //                                 .updateProfissionals(
  //                               ids: e.id!,
  //                               add: false,
  //                             );
  //                             setState(() {});
  //                           },
  //                           icon: const Icon(Icons.delete_forever),
  //                         ),
  //                         Expanded(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               AppTextTitleValue(
  //                                 title: 'Nome: ',
  //                                 value: '${e.name}',
  //                               ),
  //                               AppTextTitleValue(
  //                                 title: 'Id: ',
  //                                 value: '${e.id}',
  //                               ),
  //                               AppTextTitleValue(
  //                                 title: 'Procedimento: ',
  //                                 value: widget._eventAddEditController
  //                                     .getProcedureName(widget
  //                                         ._eventAddEditController
  //                                         .event!
  //                                         .procedures![e.id]!),
  //                               ),
  //                               AppTextTitleValue(
  //                                 title: 'Procedimento Id: ',
  //                                 value:
  //                                     '${widget._eventAddEditController.event!.procedures![e.id]}',
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ]),
  //                 ))
  //             .toList()
  //       ],
  //     );
  //   } else {
  //     return Container();
  //   }
  // }

  // Widget patientList() {
  //   if (widget._eventAddEditController.event?.patients != null) {
  //     return Column(
  //       children: [
  //         ...widget._eventAddEditController.event!.patients!
  //             .map((e) => Card(
  //                   child: Column(children: [
  //                     Row(
  //                       children: [
  //                         IconButton(
  //                           onPressed: () async {
  //                             // await saveEvent();
  //                             await widget._eventAddEditController
  //                                 .updatePatients(
  //                               ids: e.id!,
  //                               add: false,
  //                             );
  //                             setState(() {});
  //                           },
  //                           icon: const Icon(Icons.delete_forever),
  //                         ),
  //                         Expanded(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               AppTextTitleValue(
  //                                 title: 'Nome: ',
  //                                 value: '${e.name}',
  //                               ),
  //                               AppTextTitleValue(
  //                                 title: 'Id: ',
  //                                 value: '${e.id}',
  //                               ),
  //                               AppTextTitleValue(
  //                                 title: 'Convênio tipo: ',
  //                                 value: widget._eventAddEditController
  //                                     .getHealthPlan(e.id!, 'name'),
  //                               ),
  //                               AppTextTitleValue(
  //                                 title: 'Convênio código: ',
  //                                 value: widget._eventAddEditController
  //                                     .getHealthPlan(e.id!, 'code'),
  //                               ),
  //                               AppTextTitleValue(
  //                                 title: 'Convênio Id: ',
  //                                 value: widget._eventAddEditController
  //                                     .getHealthPlan(e.id!, 'id'),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ]),
  //                 ))
  //             .toList()
  //       ],
  //     );
  //   } else {
  //     return Container();
  //   }
  // }
}
