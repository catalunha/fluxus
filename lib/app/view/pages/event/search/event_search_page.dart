import 'package:flutter/material.dart';
import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/view/controllers/event/search/event_search_controller.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';
import 'package:get/get.dart';

class EventSearchPage extends StatefulWidget {
  final _eventSearchController = Get.find<EventSearchController>();
  EventSearchPage({Key? key}) : super(key: key);

  @override
  State<EventSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<EventSearchPage> {
  final _formKey = GlobalKey<FormState>();
  final bool _attendanceEqualTo = false;
  final _attendanceEqualToTEC = TextEditingController();
  bool _datetimeBool = true;
  bool _eventStatusEqualTo = false;
  final _eventStatusEqualToTEC = TextEditingController();
  bool _roomEqualTo = false;
  final _roomEqualToTEC = TextEditingController();
  final bool _myAttendance = false;
  // bool _myAttendanceEmEspera = false;
  // bool _myAttendanceAvaliacaoAgendada = false;
  // bool _myAttendanceProfissionalAgendado = false;

  @override
  void initState() {
    _attendanceEqualToTEC.text = '';
    _eventStatusEqualToTEC.text = '';
    _roomEqualToTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando eventos'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // if (!allowedAccess(OfficeEnum.secretaria.id))
                  //   Card(
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Checkbox(
                  //               value: _myAttendance,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   _myAttendance = value!;
                  //                 });
                  //               },
                  //             ),
                  //             const Text('Meus eventos.')
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _myAttendanceEmEspera,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _myAttendanceEmEspera = value!;
                  //               });
                  //             },
                  //           ),
                  //           const Text('Meus eventos. Em espera.')
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _myAttendanceAvaliacaoAgendada,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _myAttendanceAvaliacaoAgendada = value!;
                  //               });
                  //             },
                  //           ),
                  //           const Text('Meus eventos. Avaliação agendada.')
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _myAttendanceProfissionalAgendado,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _myAttendanceProfissionalAgendado = value!;
                  //               });
                  //             },
                  //           ),
                  //           const Text('Meus eventos. Profissional agendado.')
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // if (allowedAccess(OfficeEnum.secretaria.id))
                  //   Card(
                  //     child: Column(
                  //       children: [
                  //         const Text('por Guia'),
                  //         Row(
                  //           children: [
                  //             Checkbox(
                  //               value: _attendanceEqualTo,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   _attendanceEqualTo = value!;
                  //                 });
                  //               },
                  //             ),
                  //             IconButton(
                  //               onPressed: () {
                  //                 Get.toNamed(Routes.attendanceSearch);
                  //               },
                  //               icon: const Icon(Icons.search),
                  //             ),
                  //             Expanded(
                  //               child: AppTextFormField(
                  //                 label: 'Id da Guia',
                  //                 controller: _attendanceEqualToTEC,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  if (allowedAccess(OfficeEnum.secretaria.id))
                    Card(
                      child: Column(
                        children: [
                          const Text('por Data'),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Checkbox(
                                value: _datetimeBool,
                                onChanged: (value) {
                                  setState(() {
                                    _datetimeBool = value!;
                                  });
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppCalendarButton(
                                    title: "Iniciado em:",
                                    getDate: () => widget
                                        ._eventSearchController.dtStartStart,
                                    setDate: (value) => widget
                                        ._eventSearchController
                                        .dtStartStart = value,
                                  ),
                                  AppCalendarButton(
                                    title: "Finalizado em:",
                                    getDate: () => widget
                                        ._eventSearchController.dtStartEnd,
                                    setDate: (value) => widget
                                        ._eventSearchController
                                        .dtStartEnd = value,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  if (allowedAccess(OfficeEnum.secretaria.id))
                    Card(
                      child: Column(
                        children: [
                          const Text('por Ambiente'),
                          Row(
                            children: [
                              Checkbox(
                                value: _roomEqualTo,
                                onChanged: (value) {
                                  setState(() {
                                    _roomEqualTo = value!;
                                  });
                                },
                              ),
                              Obx(
                                () => AppDropDownGeneric<RoomModel>(
                                  options: widget
                                      ._eventSearchController.roomList
                                      .toList(),
                                  selected: widget
                                      ._eventSearchController.roomSelected,
                                  execute: (value) {
                                    widget._eventSearchController.roomSelected =
                                        value;
                                    setState(() {});
                                  },
                                  width: 300,
                                ),
                              ),
                              // IconButton(
                              //   onPressed: () {
                              //     Get.toNamed(Routes.roomList);
                              //   },
                              //   icon: const Icon(Icons.search),
                              // ),
                              // Expanded(
                              //   child: AppTextFormField(
                              //     label: 'Id do ambiente',
                              //     controller: _roomEqualToTEC,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Card(
                    child: Column(
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
                            Expanded(
                              child: Obx(
                                () => AppDropDownGeneric<EventStatusModel>(
                                  options: widget
                                      ._eventSearchController.eventStatusList
                                      .toList(),
                                  selected: widget._eventSearchController
                                      .eventStatusSelected,
                                  execute: (value) {
                                    widget._eventSearchController
                                        .eventStatusSelected = value;
                                    setState(() {});
                                  },
                                  // width: 330,
                                  width: double.maxFinite,
                                ),
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
            await widget._eventSearchController.search(
              myAttendance: _myAttendance,
              // myAttendanceEmEspera: _myAttendanceEmEspera,
              // myAttendanceAvaliacaoAgendada: _myAttendanceAvaliacaoAgendada,
              // myAttendanceProfissionalAgendado:
              //     _myAttendanceProfissionalAgendado,
              attendanceEqualToBool: _attendanceEqualTo,
              attendanceEqualToString: _attendanceEqualToTEC.text,
              dtStartBool: _datetimeBool,
              eventStatusEqualToBool: _eventStatusEqualTo,
              eventStatusEqualToString: _eventStatusEqualToTEC.text,
              roomEqualToBool: _roomEqualTo,
              roomEqualToString: _roomEqualToTEC.text,
            );
            // Get.back();
          }
        },
      ),
    );
  }

  bool allowedAccess(String officeId) {
    final splashController = Get.find<SplashController>();
    return splashController.officeIdList.contains(officeId);
  }
}
