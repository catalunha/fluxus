import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/expertise_model.dart';
import 'package:fluxus/app/view/controllers/evaluation/addedit/evaluation_addedit_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:validatorless/validatorless.dart';

class EvaluationAddEditPage extends StatefulWidget {
  final _evaluationAddEditController = Get.find<EvaluationAddEditController>();
  EvaluationAddEditPage({Key? key}) : super(key: key);

  @override
  State<EvaluationAddEditPage> createState() => _EvaluationAddEditPageState();
}

class _EvaluationAddEditPageState extends State<EvaluationAddEditPage> {
  final dateFormat = DateFormat('dd/MM/y');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Ficha de avaliação'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveEvaluation();
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
                          'Id: ${widget._evaluationAddEditController.evaluation?.id}',
                          style: const TextStyle(fontSize: 8),
                        )),
                    const SizedBox(height: 5),
                    const Text('Ambiente'),
                    Obx(
                      () => AppDropDownGeneric<ExpertiseModel>(
                        options: widget
                            ._evaluationAddEditController.expertiseList
                            .toList(),
                        selected: widget._evaluationAddEditController
                            .expertiseModelSelected,
                        execute: (value) {
                          widget._evaluationAddEditController
                              .expertiseModelSelected = value;
                          setState(() {});
                        },
                        width: 150,
                      ),
                    ),
                    AppTextFormField(
                      label: 'Nome',
                      controller: widget._evaluationAddEditController.nameTec,
                      validator: Validatorless.required('Nome é obrigatório'),
                    ),
                    AppTextFormField(
                      label: 'Descrição',
                      controller:
                          widget._evaluationAddEditController.descriptionTec,
                      validator:
                          Validatorless.required('Descrição é obrigatório'),
                      maxLines: 10,
                    ),
                    Obx(
                      () => CheckboxListTile(
                        title: const Text("É uma ficha pública ?"),
                        onChanged: (value) {
                          widget._evaluationAddEditController.isPublic =
                              value ?? false;
                        },
                        value: widget._evaluationAddEditController.isPublic,
                      ),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        tileColor:
                            widget._evaluationAddEditController.isDeleted!
                                ? Colors.red
                                : null,
                        title: const Text("Apagar esta ficha ?"),
                        onChanged: (value) {
                          widget._evaluationAddEditController.isDeleted =
                              value ?? false;
                        },
                        value: widget._evaluationAddEditController.isDeleted,
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

  Future<bool> saveEvaluation() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      // if (widget._evaluationAddEditController.dateBirthday == null) {
      //   return false;
      // }
      await widget._evaluationAddEditController.append(
        name: widget._evaluationAddEditController.nameTec.text,
        description: widget._evaluationAddEditController.descriptionTec.text,
        isPublic: widget._evaluationAddEditController.isPublic,
        isDeleted: widget._evaluationAddEditController.isDeleted,
      );
      return true;
    }
    return false;
  }
}
