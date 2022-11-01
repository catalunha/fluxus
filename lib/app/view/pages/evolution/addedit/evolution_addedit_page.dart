import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/evolution/addedit/evolution_addedit_controller.dart';
import 'package:get/get.dart';

import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class EvolutionAddEditPage extends StatefulWidget {
  final _evolutionAddEditController = Get.find<EvolutionAddEditController>();
  EvolutionAddEditPage({Key? key}) : super(key: key);

  @override
  State<EvolutionAddEditPage> createState() => _EvolutionAddEditPageState();
}

class _EvolutionAddEditPageState extends State<EvolutionAddEditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar evolução'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveEvolution();
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
                          'Id: ${widget._evolutionAddEditController.evolution?.id}',
                          style: const TextStyle(fontSize: 8),
                        )),
                    const SizedBox(height: 5),
                    // const Text('Especialidade'),
                    // Obx(
                    //   () => AppDropDownGeneric<EvaluationModel>(
                    //     options: widget
                    //         ._evolutionAddEditController.evaluationList
                    //         .toList(),
                    //     selected: widget
                    //         ._evolutionAddEditController.evaluationSelected,
                    //     execute: (value) {
                    //       widget._evolutionAddEditController
                    //           .evaluationSelected = value;
                    //       setState(() {});
                    //     },
                    //     width: 150,
                    //   ),
                    // ),
                    AppTextFormField(
                      label: 'Descrição',
                      controller:
                          widget._evolutionAddEditController.descriptionTec,
                      validator:
                          Validatorless.required('Descrição é obrigatório'),
                      maxLines: 10,
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

  Future<bool> saveEvolution() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      await widget._evolutionAddEditController.append(
        description: widget._evolutionAddEditController.descriptionTec.text,
      );
      return true;
    }
    return false;
  }
}
