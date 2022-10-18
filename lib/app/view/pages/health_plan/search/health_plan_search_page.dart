import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/health_plan/search/health_plan_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';

class HealthPlanSearchPage extends StatefulWidget {
  final _healthPlanSearchController = Get.find<HealthPlanSearchController>();
  HealthPlanSearchPage({Key? key}) : super(key: key);

  @override
  State<HealthPlanSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<HealthPlanSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _codeContains = false;
  final _codeContainsTEC = TextEditingController();

  @override
  void initState() {
    _codeContainsTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando convênios'),
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
                        const Text('por Código'),
                        Row(
                          children: [
                            Checkbox(
                              value: _codeContains,
                              onChanged: (value) {
                                setState(() {
                                  _codeContains = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Código que contém',
                                controller: _codeContainsTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Card(
                  //   child: Column(
                  //     children: [
                  //       const Text('por Data de nascimento'),
                  //       const SizedBox(height: 5),
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _birthday,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _birthday = value!;
                  //               });
                  //             },
                  //           ),
                  //           AppCalendarButton(
                  //             title: "Data de nascimento.",
                  //             getDate: () =>
                  //                 widget._healthPlanSearchController.selectedDate,
                  //             setDate: (value) => widget
                  //                 ._healthPlanSearchController.selectedDate = value,
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
            await widget._healthPlanSearchController.search(
              codeContainsBool: _codeContains,
              codeContainsString: _codeContainsTEC.text,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
