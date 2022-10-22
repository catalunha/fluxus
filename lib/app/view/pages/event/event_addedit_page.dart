import 'package:flutter/material.dart';
import 'package:fluxus/app/core/utils/start_date_drop_down.dart';
import 'package:fluxus/app/view/controllers/event/addedit/event_addedit_controller.dart';
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
  StartDateDropDrow? startDateDropDrowSelected;
  StartDateDropDrow? endDateDropDrowSelected;

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
      body: FutureBuilder<void>(
          future: widget._eventAddEditController.getEvent(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Id: ${widget._eventAddEditController.event?.id}',
                              style: const TextStyle(fontSize: 8),
                            ),
                            const SizedBox(height: 5),
                            AppTextFormField(
                              label: 'Autorização',
                              controller: widget
                                  ._eventAddEditController.autorizationTec,
                            ),
                            AppTextFormField(
                              label: 'Fatura',
                              controller:
                                  widget._eventAddEditController.faturaTec,
                            ),
                            AppTextFormField(
                              label: 'Descrição',
                              controller:
                                  widget._eventAddEditController.descriptionTec,
                            ),
                            AppCalendarButton(
                              title: "Data do atendimento.",
                              getDate: () =>
                                  widget._eventAddEditController.dateStart,
                              setDate: (value) => widget
                                  ._eventAddEditController.dateStart = value,
                              isBirthDay: false,
                            ),
                            const Text('Horário do atendimento'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const Text('Início'),
                                    Obx(() =>
                                        AppDropDownGeneric<StartDateDropDrow>(
                                          options: widget
                                              ._eventAddEditController
                                              .startDateList
                                              .toList(),
                                          selected: startDateDropDrowSelected,
                                          execute: (value) {
                                            startDateDropDrowSelected = value;

                                            setState(() {});
                                          },
                                          width: 150,
                                        )),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Fim'),
                                    Obx(() =>
                                        AppDropDownGeneric<StartDateDropDrow>(
                                          options: widget
                                              ._eventAddEditController
                                              .startDateList
                                              .toList(),
                                          selected: endDateDropDrowSelected,
                                          execute: (value) {
                                            endDateDropDrowSelected = value;
                                            setState(() {});
                                          },
                                          width: 150,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Profissionais'),
                                IconButton(
                                  onPressed: () async {
                                    var result = await saveEvent();
                                    if (result) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container();
                                        },
                                        // EventAddFamilyChildren(
                                        //     isChildren: false),
                                      );
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
                            familyList(),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
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
      );
      return true;
    }
    return false;
  }

  Widget familyList() {
    if (widget._eventAddEditController.event?.professionals != null) {
      return Obx(() => Column(
            children: [
              ...widget._eventAddEditController.event!.professionals!
                  .map((e) => Card(
                        child: Column(children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // await saveEvent();
                                  // await widget._eventAddEditController.familyUpdate(
                                  //   id: e.id!,
                                  //   isAdd: false,
                                  // );
                                  // setState(() {});
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
          ));
    } else {
      return Container();
    }
  }
}
