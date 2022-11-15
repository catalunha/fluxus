import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/core/models/procedure_model.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/attendance/addedit/attendance_addedit_controller.dart';
import 'package:fluxus/app/view/pages/attendance/addedit/part/attendance_add_ids.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class AttendanceAddEditPage extends StatefulWidget {
  final _attendanceAddEditController = Get.find<AttendanceAddEditController>();
  AttendanceAddEditPage({Key? key}) : super(key: key);

  @override
  State<AttendanceAddEditPage> createState() => _AttendanceAddEditPageState();
}

class _AttendanceAddEditPageState extends State<AttendanceAddEditPage> {
  final dateFormat = DateFormat('dd/MM/y');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerar atendimentos'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveAttendance();
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
                    AppTextTitleValue(
                      title: 'Id: ',
                      value: widget._attendanceAddEditController.attendanceId,
                    ),
                    const SizedBox(height: 5),

                    patientWidget(context),

                    professionalWidget(context),

                    // if (widget._attendanceAddEditController.professional != null)
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     IconButton(
                    //         onPressed: () {
                    //           Get.toNamed(Routes.teamProfileSearch);
                    //         },
                    //         icon: const Icon(Icons.search)),
                    //     const Text('Procedimentos'),
                    //     IconButton(
                    //       onPressed: () async {
                    //         // var result = await saveAttendance();
                    //         // if (result) {
                    //         String? res = await showDialog(
                    //           barrierDismissible: false,
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return const AttendanceAddIds(
                    //               title:
                    //                   'Informe o Id do profissional e do procedimento',
                    //               formFieldLabel: 'Separador por espaço',
                    //             );
                    //           },
                    //         );
                    //         if (res != null) {
                    //           widget._attendanceAddEditController
                    //               .setProcedure(ids: res, add: true);
                    //         }
                    //         setState(() {});
                    //         // } else {
                    //         //   Get.snackbar(
                    //         //     'Atenção',
                    //         //     'Campos obrigatórios não foram preenchidos.',
                    //         //     backgroundColor: Colors.red,
                    //         //   );
                    //         // }
                    //       },
                    //       icon: const Icon(Icons.add),
                    //     )
                    //   ],
                    // ),

                    AppTextFormField(
                      label: 'Observações',
                      controller:
                          widget._attendanceAddEditController.descriptionTec,
                    ),
                    AppTextFormField(
                      label: 'Número da Autorização',
                      controller:
                          widget._attendanceAddEditController.autorizationTec,
                    ),

                    AppCalendarButton(
                      title: "Data limite da autorização.",
                      getDate: () =>
                          widget._attendanceAddEditController.dAutorization,
                      setDate: (value) => widget
                          ._attendanceAddEditController.dAutorization = value,
                      isBirthDay: false,
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

  Widget professionalWidget(BuildContext context) {
    if (widget._attendanceAddEditController.attendanceId == null) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.teamProfileSearch,
                        arguments: ['name', 'procedure']);
                  },
                  icon: const Icon(Icons.search)),
              const Text('Profissional'),
              IconButton(
                onPressed: () async {
                  // var result = await saveAttendance();
                  // if (result) {
                  String? res = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const AttendanceAddIds(
                        title: 'Informe o Id do profissional',
                        formFieldLabel: '',
                      );
                    },
                  );
                  if (res != null) {
                    widget._attendanceAddEditController
                        .setProfissional(id: res);
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
          Obx(() => professional()),
          Obx(() => procedureList()),
        ],
      );
    } else {
      return Column(
        children: [
          const Text('Profissional'),
          Obx(() => professional()),
          const Text('Procedimento'),
          Obx(() => procedure()),
        ],
      );
    }
  }

  Widget patientWidget(BuildContext context) {
    if (widget._attendanceAddEditController.attendanceId == null) {
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
                  // var result = await saveAttendance();
                  // if (result) {
                  String? res = await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return const AttendanceAddIds(
                        title: 'Informe o Id do paciente',
                        formFieldLabel: 'Id do paciente',
                      );
                    },
                  );
                  if (res != null) {
                    widget._attendanceAddEditController.setPatient(id: res);
                  }
                  log(res ?? '...', name: 'res');
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
          Obx(() => patient()),
          Obx(() => healthPlanList()),
        ],
      );
    } else {
      return Column(
        children: [
          const Text('Paciente'),
          Obx(() => patient()),
          const Text('Convênio'),
          Obx(() => healthPlan()),
        ],
      );
    }
  }

  Future<bool> saveAttendance() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      // if (widget._attendanceAddEditController.dAutorization == null) {
      //   return false;
      // }
      if (widget._attendanceAddEditController.healthPlanList.length > 1) {
        return false;
      }
      if (widget._attendanceAddEditController.procedureList.isEmpty) {
        return false;
      }
      await widget._attendanceAddEditController.append(
        autorization: widget._attendanceAddEditController.autorizationTec.text,
        description: widget._attendanceAddEditController.descriptionTec.text,
      );
      return true;
    }
    return false;
  }

// HEGkYcanUF QaEqV7GJWk
  Widget patient() {
    if (widget._attendanceAddEditController.patient != null) {
      ProfileModel patient = widget._attendanceAddEditController.patient!;
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
              //       widget._attendanceAddEditController.getHealthPlan('name'),
              // ),
              // AppTextTitleValue(
              //   title: 'Convênio código: ',
              //   value:
              //       widget._attendanceAddEditController.getHealthPlan('code'),
              // ),
              // AppTextTitleValue(
              //   title: 'Convênio Id: ',
              //   value: widget._attendanceAddEditController.getHealthPlan('id'),
              // ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget healthPlan() {
    if (widget._attendanceAddEditController.healthPlanModel != null) {
      HealthPlanModel healthPlanModel =
          widget._attendanceAddEditController.healthPlanModel!;
      return Card(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextTitleValue(
                title: 'Id: ',
                value: '${healthPlanModel.id}',
              ),
              AppTextTitleValue(
                title: 'Code: ',
                value: '${healthPlanModel.code}',
              ),
              AppTextTitleValue(
                title: 'Descrição: ',
                value: '${healthPlanModel.description}',
              ),
              AppTextTitleValue(
                title: 'Nome: ',
                value: '${healthPlanModel.healthPlanType!.name}',
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget healthPlanList() {
    if (widget._attendanceAddEditController.healthPlanList.isNotEmpty) {
      return Column(
        children: [
          const Text('Deixe apenas 1 Plano de saúde:'),
          ...widget._attendanceAddEditController.healthPlanList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  widget._attendanceAddEditController
                                      .removeHealthPlan(e.id!);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                            ],
                          ),
                          Expanded(
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

// a4HhGpRLLx
  Widget professional() {
    if (widget._attendanceAddEditController.professional != null) {
      ProfileModel profileModel =
          widget._attendanceAddEditController.professional!;
      return Card(
        child: SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              IconButton(
                onPressed: () => copy(profileModel.id!),
                icon: const Icon(
                  Icons.copy,
                ),
              ),
              Column(
                children: [
                  AppTextTitleValue(
                    title: 'Nome: ',
                    value: '${profileModel.name}',
                  ),
                  AppTextTitleValue(
                    title: 'Id: ',
                    value: '${profileModel.id}',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget procedure() {
    if (widget._attendanceAddEditController.procedure != null) {
      ProcedureModel procedureModel =
          widget._attendanceAddEditController.procedure!;
      return Card(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              AppTextTitleValue(
                title: 'Id: ',
                value: '${procedureModel.id}',
              ),
              AppTextTitleValue(
                title: 'Nome: ',
                value: '${procedureModel.name}',
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
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

  Widget procedureList() {
    if (widget._attendanceAddEditController.procedureList.isNotEmpty) {
      return Column(
        children: [
          const Text('Deixe pelo menos 1 Procedimento:'),
          ...widget._attendanceAddEditController.procedureList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  widget._attendanceAddEditController
                                      .removeProcedure(e.id!);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                              IconButton(
                                onPressed: () async {
                                  widget._attendanceAddEditController
                                      .addProcedure(e);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.add_to_photos_outlined),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTextTitleValue(
                                  title: 'Código: ',
                                  value: e.code,
                                ),
                                AppTextTitleValue(
                                  title: 'Nome: ',
                                  value: e.name,
                                ),
                                AppTextTitleValue(
                                  title: 'Id: ',
                                  value: e.id,
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
}
