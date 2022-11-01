import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/attendance/search/attendance_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';

class AttendanceSearchPage extends StatefulWidget {
  final _attendanceController = Get.find<AttendanceSearchController>();
  AttendanceSearchPage({Key? key}) : super(key: key);

  @override
  State<AttendanceSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<AttendanceSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _professionalEqualTo = false;
  bool _patientEqualTo = false;
  bool _procedureEqualTo = false;
  bool _eventStatusEqualTo = false;
  bool _autorizationEqualTo = false;
  bool _eventEqualTo = false;
  bool _dAutorization = false;
  bool _dAttendance = false;
  final _professionalEqualToTEC = TextEditingController();
  final _patientEqualToTEC = TextEditingController();
  final _procedureEqualToTEC = TextEditingController();
  final _eventStatusEqualToTEC = TextEditingController();
  final _autorizationEqualToTEC = TextEditingController();
  final _eventEqualToTEC = TextEditingController();

  @override
  void initState() {
    _professionalEqualToTEC.text = '';
    _patientEqualToTEC.text = '';
    _procedureEqualToTEC.text = '';
    _eventStatusEqualToTEC.text = '';
    _autorizationEqualToTEC.text = '';
    _eventEqualToTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando atendimentos'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        const Text('por Profissional'),
                        Row(
                          children: [
                            Checkbox(
                              value: _professionalEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _professionalEqualTo = value!;
                                });
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.teamProfileSearch);
                              },
                              icon: const Icon(Icons.search),
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Profissional com Id',
                                controller: _professionalEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Procedimento'),
                        Row(
                          children: [
                            Checkbox(
                              value: _procedureEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _procedureEqualTo = value!;
                                });
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.procedureList);
                              },
                              icon: const Icon(Icons.search),
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Procedimento com Id',
                                controller: _procedureEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('por Status do evento'),
                        Row(
                          children: [
                            Checkbox(
                              value: _eventStatusEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _eventStatusEqualTo = value!;
                                });
                              },
                            ),
                            Obx(
                              () => AppDropDownGeneric<EventStatusModel>(
                                options: widget
                                    ._attendanceController.eventStatusList
                                    .toList(),
                                selected: widget
                                    ._attendanceController.eventStatusSelected,
                                execute: (value) {
                                  widget._attendanceController
                                      .eventStatusSelected = value;
                                  print(value);
                                  print(widget._attendanceController
                                      .eventStatusSelected);
                                  setState(() {});
                                },
                                width: 300,
                              ),
                            ),
                            // IconButton(
                            //   onPressed: () {
                            //     Get.toNamed(Routes.eventStatusList);
                            //   },
                            //   icon: const Icon(Icons.search),
                            // ),
                            // Expanded(
                            //   child: AppTextFormField(
                            //     label: 'Status do evento com Id',
                            //     controller: _eventStatusEqualToTEC,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       const Text('por Status do evento'),
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _eventStatusEqualTo,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _eventStatusEqualTo = value!;
                  //               });
                  //             },
                  //           ),
                  //           IconButton(
                  //             onPressed: () {
                  //               Get.toNamed(Routes.eventStatusList);
                  //             },
                  //             icon: const Icon(Icons.search),
                  //           ),
                  //           Expanded(
                  //             child: AppTextFormField(
                  //               label: 'Status do evento com Id',
                  //               controller: _eventStatusEqualToTEC,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Paciente'),
                        Row(
                          children: [
                            Checkbox(
                              value: _patientEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _patientEqualTo = value!;
                                });
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.toNamed(Routes.clientProfileSearch);
                                },
                                icon: const Icon(Icons.search)),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Paciente com Id',
                                controller: _patientEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Autorizacao'),
                        Row(
                          children: [
                            Checkbox(
                              value: _autorizationEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _autorizationEqualTo = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Número da Autorizacao',
                                controller: _autorizationEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Evento'),
                        Row(
                          children: [
                            Checkbox(
                              value: _eventEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _eventEqualTo = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Id do Evento',
                                controller: _eventEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Data de autorização'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                              value: _dAutorization,
                              onChanged: (value) {
                                setState(() {
                                  _dAutorization = value!;
                                });
                              },
                            ),
                            AppCalendarButton(
                              title: "Data da autorização.",
                              getDate: () =>
                                  widget._attendanceController.dAutorization,
                              setDate: (value) => widget
                                  ._attendanceController.dAutorization = value,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Data de atendimento'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                              value: _dAttendance,
                              onChanged: (value) {
                                setState(() {
                                  _dAttendance = value!;
                                });
                              },
                            ),
                            AppCalendarButton(
                              title: "Data da atendimento.",
                              getDate: () =>
                                  widget._attendanceController.dAttendance,
                              setDate: (value) => widget
                                  ._attendanceController.dAttendance = value,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100)
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Executar busca',
        child: const Icon(AppIconData.search),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._attendanceController.search(
              professionalEqualToBool: _professionalEqualTo,
              professionalEqualToString: _professionalEqualToTEC.text,
              patientEqualToBool: _patientEqualTo,
              patientEqualToString: _patientEqualToTEC.text,
              procedureEqualToBool: _procedureEqualTo,
              procedureEqualToString: _procedureEqualToTEC.text,
              eventStatusEqualToBool: _eventStatusEqualTo,
              eventStatusEqualToString: _eventStatusEqualToTEC.text,
              autorizationEqualToBool: _autorizationEqualTo,
              autorizationEqualToString: _autorizationEqualToTEC.text,
              eventEqualToBool: _eventEqualTo,
              eventEqualToString: _eventEqualToTEC.text,
              dAutorizationBool: _dAutorization,
              dAttendanceBool: _dAttendance,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
