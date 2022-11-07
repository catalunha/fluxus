import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/room_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/event/search/event_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';

class EventSearchPage extends StatefulWidget {
  final _eventSearchController = Get.find<EventSearchController>();
  EventSearchPage({Key? key}) : super(key: key);

  @override
  State<EventSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<EventSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _attendanceEqualTo = false;
  final _attendanceEqualToTEC = TextEditingController();
  bool _dtStartBool = false;
  bool _eventStatusEqualTo = false;
  final _eventStatusEqualToTEC = TextEditingController();
  bool _roomEqualTo = false;
  final _roomEqualToTEC = TextEditingController();
  bool _myAttendance = false;

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
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _myAttendance,
                              onChanged: (value) {
                                setState(() {
                                  _myAttendance = value!;
                                });
                              },
                            ),
                            const Text('Eventos em que estou envolvido.')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Guia'),
                        Row(
                          children: [
                            Checkbox(
                              value: _attendanceEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _attendanceEqualTo = value!;
                                });
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.attendanceSearch);
                              },
                              icon: const Icon(Icons.search),
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Id da Guia',
                                controller: _attendanceEqualToTEC,
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
                                    ._eventSearchController.eventStatusList
                                    .toList(),
                                selected: widget
                                    ._eventSearchController.eventStatusSelected,
                                execute: (value) {
                                  widget._eventSearchController
                                      .eventStatusSelected = value;
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
                                options: widget._eventSearchController.roomList
                                    .toList(),
                                selected:
                                    widget._eventSearchController.roomSelected,
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
                        const Text('por Data de atendimento'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                              value: _dtStartBool,
                              onChanged: (value) {
                                setState(() {
                                  _dtStartBool = value!;
                                });
                              },
                            ),
                            AppCalendarButton(
                              title: "Data da atendimento.",
                              getDate: () =>
                                  widget._eventSearchController.dtStart,
                              setDate: (value) =>
                                  widget._eventSearchController.dtStart = value,
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
            await widget._eventSearchController.search(
              myAttendance: _myAttendance,
              attendanceEqualToBool: _attendanceEqualTo,
              attendanceEqualToString: _attendanceEqualToTEC.text,
              dtStartBool: _dtStartBool,
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
}
