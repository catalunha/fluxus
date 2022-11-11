import 'package:flutter/material.dart';
import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/core/utils/start_date_drop_down.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/event/addedit/event_addedit_controller.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
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
                    Obx(() => Text(
                          'Id: ${widget._eventAddEditController.event?.id}',
                        )),
                    // Obx(() => Text(widget._eventAddEditController.dateStart
                    //         ?.toIso8601String() ??
                    //     '...')),
                    // Obx(() => Text(widget._eventAddEditController.dateEnd
                    //         ?.toIso8601String() ??
                    //     '...')),
                    if (allowedAccess(OfficeEnum.secretaria.id))
                      AppCalendarButton(
                        title: "Data do atendimento.",
                        getDate: () => widget._eventAddEditController.dateStart,
                        setDate: (value) =>
                            widget._eventAddEditController.dateStart = value,
                        isBirthDay: false,
                      ),
                    // const Text('Horário do atendimento'),
                    if (allowedAccess(OfficeEnum.secretaria.id))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Text('Início'),
                              Obx(() => AppDropDownGeneric<StartDateDropDrow>(
                                    options: widget
                                        ._eventAddEditController.startDateList
                                        .toList(),
                                    selected: widget._eventAddEditController
                                        .startDateDropDrowSelected,
                                    execute: (value) {
                                      widget._eventAddEditController
                                          .startDateDropDrowSelected = value;
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
                                  options: widget
                                      ._eventAddEditController.startDateList
                                      .toList(),
                                  selected: widget._eventAddEditController
                                      .endDateDropDrowSelected,
                                  execute: (value) {
                                    widget._eventAddEditController
                                        .endDateDropDrowSelected = value;
                                    widget._eventAddEditController
                                        .onUpdateEnd(value!);
                                    setState(() {});
                                  },
                                  width: 150,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    if (allowedAccess(OfficeEnum.secretaria.id))
                      Column(
                        children: [
                          const Text('Ambiente'),
                          Obx(
                            () => AppDropDownGeneric<RoomModel>(
                              options: widget._eventAddEditController.roomList
                                  .toList(),
                              selected: widget
                                  ._eventAddEditController.roomModelSelected,
                              execute: (value) {
                                widget._eventAddEditController
                                    .roomModelSelected = value;
                                setState(() {});
                              },
                              width: double.maxFinite,
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 10),
                    if (allowedAccess(OfficeEnum.secretaria.id))
                      Column(
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
                                    await widget._eventAddEditController
                                        .addAttendance(res);
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
                      ),
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

  bool allowedAccess(String officeId) {
    final splashController = Get.find<SplashController>();
    return splashController.officeIdList.contains(officeId);
  }

  Future<bool> saveEvent() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      print('oops1');
      if (widget._eventAddEditController.dateStart == null) {
        print('oops2');
        return false;
      }
      if (widget._eventAddEditController.eventStatusSelected == null) {
        print('oops3');
        return false;
      }
      if (widget._eventAddEditController.attendanceList.isEmpty) {
        print('oops4');
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
                          IconButton(
                            onPressed: () async {
                              // await saveEvent();
                              await widget._eventAddEditController
                                  .removeAttendance(e.id!);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextTitleValue(
                                  title: 'Atendimento Id: ',
                                  value: '${e.id}',
                                ),
                                AppTextTitleValue(
                                  title: 'Pac. Nome: ',
                                  value: '${e.patient!.name}',
                                ),
                                AppTextTitleValue(
                                  title: 'Id: ',
                                  value: '${e.patient!.id}',
                                ),
                                AppTextTitleValue(
                                  title: 'Prof. Nome: ',
                                  value: '${e.professional!.name}',
                                ),
                                AppTextTitleValue(
                                  title: 'Id: ',
                                  value: '${e.professional!.id}',
                                ),
                                AppTextTitleValue(
                                  title: 'Id: ',
                                  value: '${e.procedure!.name}',
                                ),
                              ],
                            ),
                          )
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
