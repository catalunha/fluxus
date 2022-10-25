import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/core/utils/start_date_drop_down.dart';
import 'package:fluxus/app/view/controllers/event/addedit/event_addedit_controller.dart';
import 'package:fluxus/app/view/pages/event/addedit/part/event_add_ids.dart';
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
                    Obx(() => Text(
                          'Id: ${widget._eventAddEditController.event?.id}',
                          style: const TextStyle(fontSize: 8),
                        )),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      label: 'Autorização',
                      controller:
                          widget._eventAddEditController.autorizationTec,
                    ),
                    AppTextFormField(
                      label: 'Fatura',
                      controller: widget._eventAddEditController.faturaTec,
                    ),
                    AppTextFormField(
                      label: 'Descrição',
                      controller: widget._eventAddEditController.descriptionTec,
                    ),
                    AppCalendarButton(
                      title: "Data do atendimento.",
                      getDate: () => widget._eventAddEditController.dateStart,
                      setDate: (value) =>
                          widget._eventAddEditController.dateStart = value,
                      isBirthDay: false,
                    ),
                    const Text('Horário do atendimento'),
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
                                        .onUpdateEnd(value!);
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
                                  setState(() {});
                                },
                                width: 150,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text('Ambiente'),
                    Obx(
                      () => AppDropDownGeneric<RoomModel>(
                        options:
                            widget._eventAddEditController.roomList.toList(),
                        selected:
                            widget._eventAddEditController.roomModelSelected,
                        execute: (value) {
                          widget._eventAddEditController.roomModelSelected =
                              value;
                          setState(() {});
                        },
                        width: 150,
                      ),
                    ),
                    const Text('Status'),
                    Obx(
                      () => AppDropDownGeneric<EventStatusModel>(
                        options: widget._eventAddEditController.eventStatusList
                            .toList(),
                        selected:
                            widget._eventAddEditController.eventStatusSelected,
                        execute: (value) {
                          widget._eventAddEditController.eventStatusSelected =
                              value;
                          setState(() {});
                        },
                        width: 150,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Profissionais'),
                        IconButton(
                          onPressed: () async {
                            var result = await saveEvent();
                            if (result) {
                              String? res = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return const EventAddIds(
                                    title: 'Informe os profissionais',
                                  );
                                },
                              );
                              if (res != null) {
                                widget._eventAddEditController
                                    .updateProfissionals(ids: res, add: true);
                              }
                              log(res ?? '...', name: 'res');
                              setState(() {});
                            } else {
                              Get.snackbar(
                                'Atenção',
                                'Campos obrigatórios não foram preenchidos.',
                                backgroundColor: Colors.red,
                              );
                            }
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                    Obx(() => profissionalList()),
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

  Future<bool> saveEvent() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      // if (widget._eventAddEditController.dateBirthday == null) {
      //   return false;
      // }
      await widget._eventAddEditController.append(
        autorization: widget._eventAddEditController.autorizationTec.text,
        fatura: widget._eventAddEditController.faturaTec.text,
        description: widget._eventAddEditController.descriptionTec.text,
        room: widget._eventAddEditController.roomModelSelected,
        status: widget._eventAddEditController.eventStatusSelected,
      );
      return true;
    }
    return false;
  }

  Widget profissionalList() {
    if (widget._eventAddEditController.event?.professionals != null) {
      return Column(
        children: [
          ...widget._eventAddEditController.event!.professionals!
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              // await saveEvent();
                              await widget._eventAddEditController
                                  .updateProfissionals(
                                ids: e.id!,
                                add: false,
                              );
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete_forever),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextTitleValue(
                                title: 'Nome: ',
                                value: '${e.name}',
                              ),
                              AppTextTitleValue(
                                title: 'Id: ',
                                value: '${e.id}',
                              ),
                            ],
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
}
