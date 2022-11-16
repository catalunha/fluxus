import 'package:flutter/material.dart';
import 'package:fluxus/app/core/enums/office_enum.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/core/utils/allowed_access.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/expect/search/expect_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';

class ExpectSearchPage extends StatefulWidget {
  final _expectController = Get.find<ExpectSearchController>();
  ExpectSearchPage({Key? key}) : super(key: key);

  @override
  State<ExpectSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<ExpectSearchPage> {
  final _formKey = GlobalKey<FormState>();
  final bool _isArchived = false;
  bool _patientEqualTo = false;
  bool _eventStatusEqualTo = false;
  bool _expertiseEqualTo = false;
  final _patientEqualToTEC = TextEditingController();

  @override
  void initState() {
    _patientEqualToTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando em lista de espera'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       const Text('por Arquivadas'),
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _isArchived,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _isArchived = value!;
                  //               });
                  //             },
                  //           ),
                  //           const Text('Esperas arquivadas')
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                                }),
                            Expanded(
                              child: Obx(
                                () => AppDropDownGeneric<EventStatusModel>(
                                  options: widget
                                      ._expectController.eventStatusList
                                      .toList(),
                                  selected: widget
                                      ._expectController.eventStatusSelected,
                                  execute: (value) {
                                    widget._expectController
                                        .eventStatusSelected = value;
                                    print(value);
                                    print(widget
                                        ._expectController.eventStatusSelected);
                                    setState(() {});
                                  },
                                  // width: 340,
                                  width: double.maxFinite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (AllowedAccess.consultFor([OfficeEnum.secretaria.id]))
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('por Especialidade'),
                          Row(
                            children: [
                              Checkbox(
                                  value: _expertiseEqualTo,
                                  onChanged: (value) {
                                    setState(() {
                                      _expertiseEqualTo = value!;
                                    });
                                  }),
                              Expanded(
                                child: Obx(
                                  () => AppDropDownGeneric<ExpertiseModel>(
                                    options: widget
                                        ._expectController.expertiseList
                                        .toList(),
                                    selected: widget
                                        ._expectController.expertiseSelected,
                                    execute: (value) {
                                      widget._expectController
                                          .expertiseSelected = value;
                                      setState(() {});
                                    },
                                    // width: 340,
                                    width: double.maxFinite,
                                  ),
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
            await widget._expectController.search(
              isArchived: _isArchived,
              patientEqualToBool: _patientEqualTo,
              patientEqualToString: _patientEqualToTEC.text,
              eventStatusEqualToBool: _eventStatusEqualTo,
              expertiseEqualToBool: _expertiseEqualTo,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
