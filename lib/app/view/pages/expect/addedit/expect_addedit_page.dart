import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/core/utils/allowed_access.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/expect/addedit/expect_addedit_controller.dart';
import 'package:fluxus/app/view/pages/expect/addedit/part/expect_add_ids.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';

import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class ExpectAddEditPage extends StatefulWidget {
  final _expectAddEditController = Get.find<ExpectAddEditController>();
  ExpectAddEditPage({Key? key}) : super(key: key);

  @override
  State<ExpectAddEditPage> createState() => _ExpectAddEditPageState();
}

class _ExpectAddEditPageState extends State<ExpectAddEditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar lista de espera'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveExpect();
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
                    description(),
                    patientField(context),
                    Column(
                      children: [
                        const Text('* Status do evento'),
                        Obx(
                          () => AppDropDownGeneric<EventStatusModel>(
                            options: widget
                                ._expectAddEditController.eventStatusList
                                .toList(),
                            selected: widget
                                ._expectAddEditController.eventStatusSelected,
                            execute: (value) {
                              widget._expectAddEditController
                                  .eventStatusSelected = value;
                              setState(() {});
                            },
                            width: double.maxFinite,
                          ),
                        ),
                      ],
                    ),
                    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id]))
                      Column(
                        children: [
                          const Text('* Especialidade'),
                          Obx(
                            () => AppDropDownGeneric<ExpertiseModel>(
                              options: widget
                                  ._expectAddEditController.expertiseList
                                  .toList(),
                              selected: widget
                                  ._expectAddEditController.expertiseSelected,
                              execute: (value) {
                                widget._expectAddEditController
                                    .expertiseSelected = value;
                                setState(() {});
                              },
                              width: double.maxFinite,
                            ),
                          ),
                        ],
                      ),
                    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id]))
                      Obx(
                        () => CheckboxListTile(
                          title: const Text("Arquivar esta espera ?"),
                          onChanged: (value) {
                            widget._expectAddEditController.isArchived =
                                value ?? false;
                          },
                          value: widget._expectAddEditController.isArchived,
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

  Widget patientField(BuildContext context) {
    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id])) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.clientProfileSearch,
                        arguments: ['name', 'healthPlan']);
                  },
                  icon: const Icon(Icons.search)),
              const Text('Paciente'),
              IconButton(
                onPressed: () async {
                  // var result = await saveExpect();
                  // if (result) {
                  String? res = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const ExpectAddIds(
                        title: 'Informe o Id do paciente',
                        formFieldLabel: 'Id do paciente',
                      );
                    },
                  );
                  if (res != null) {
                    widget._expectAddEditController.setPatient(id: res);
                  }
                  log(res ?? '...', name: 'res');
                  setState(() {});
                },
                icon: const Icon(Icons.add),
              )
            ],
          ),
          Obx(() => patient()),
          Obx(() => healthPlanList()),
        ],
      );
    } else {
      return Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: const [
          //     Text('Paciente'),
          //   ],
          // ),
          const AppTextTitleValue(
            title: 'Paciente: ',
            value: ' ',
            inColumn: true,
          ),
          Obx(() => patient()),
          Obx(() => healthPlanList2()),
        ],
      );
    }
  }

  Widget description() {
    if (AllowedAccess.consultFor([OfficeEnum.secretaria.id])) {
      return AppTextFormField(
        label: 'Descrição',
        controller: widget._expectAddEditController.descriptionTec,
        maxLines: 3,
      );
    } else {
      return Obx(() => AppTextTitleValue(
            title: 'Descrição: ',
            value: widget._expectAddEditController.expect?.description,
            inColumn: true,
          ));
    }
  }

  Future<bool> saveExpect() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      if (widget._expectAddEditController.healthPlanList.length > 1) {
        return false;
      }

      await widget._expectAddEditController.append();
      return true;
    }
    return false;
  }

// HEGkYcanUF QaEqV7GJWk
  Widget patient() {
    if (widget._expectAddEditController.patient != null) {
      ProfileModel patient = widget._expectAddEditController.patient!;
      return Card(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextTitleValue(
                title: 'Nome: ',
                value: '${patient.name}',
              ),
              AppTextTitleValue(
                title: 'Id: ',
                value: '${patient.id}',
              ),
              // AppTextTitleValue(
              //   title: 'Convênio tipo: ',
              //   value:
              //       widget._expectAddEditController.getHealthPlan('name'),
              // ),
              // AppTextTitleValue(
              //   title: 'Convênio código: ',
              //   value:
              //       widget._expectAddEditController.getHealthPlan('code'),
              // ),
              // AppTextTitleValue(
              //   title: 'Convênio Id: ',
              //   value: widget._expectAddEditController.getHealthPlan('id'),
              // ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget healthPlanList() {
    if (widget._expectAddEditController.healthPlanList.isNotEmpty) {
      return Column(
        children: [
          const Text('Deixe apenas 1 Plano de saúde:'),
          ...widget._expectAddEditController.healthPlanList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  widget._expectAddEditController
                                      .removeHealthPlan(e.id!);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                            ],
                          ),
                          healthPlanData(e)
                        ],
                      ),
                    ]),
                  ))
              .toList()
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget healthPlanList2() {
    if (widget._expectAddEditController.healthPlanList.isNotEmpty) {
      return Column(
        children: [
          // const Text('Deixe apenas 1 Plano de saúde:'),
          ...widget._expectAddEditController.healthPlanList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          // Column(
                          //   children: [
                          //     IconButton(
                          //       onPressed: () async {
                          //         widget._expectAddEditController
                          //             .removeHealthPlan(e.id!);
                          //         setState(() {});
                          //       },
                          //       icon: const Icon(Icons.delete_forever),
                          //     ),
                          //   ],
                          // ),
                          healthPlanData(e)
                        ],
                      ),
                    ]),
                  ))
              .toList()
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Expanded healthPlanData(HealthPlanModel e) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextTitleValue(
            title: 'Gestor: ',
            value: e.healthPlanType!.name,
          ),
          AppTextTitleValue(
            title: 'Código: ',
            value: e.code,
          ),
          AppTextTitleValue(
            title: 'Descrição: ',
            value: e.description,
          ),
          AppTextTitleValue(
            title: 'Id: ',
            value: e.id,
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
}
