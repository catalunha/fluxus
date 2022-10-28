import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/health_plan_type_model.dart';
import 'package:fluxus/app/view/controllers/profile/user/user_profile_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_dropdown_generic.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';

import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:validatorless/validatorless.dart';

class HealthPlanAddEditPage extends StatefulWidget {
  final HealthPlanModel? healthPlanModel = Get.arguments;
  final _profileController = Get.find<UserProfileController>();
  HealthPlanAddEditPage({
    Key? key,
  }) : super(key: key);

  @override
  _HealthPlanAddEditPageState createState() => _HealthPlanAddEditPageState();
}

class _HealthPlanAddEditPageState extends State<HealthPlanAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  bool _isDeleted = false;
  HealthPlanTypeModel? healthPlanTypeSelected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _codeTec.text = widget.healthPlanModel?.code ?? "";
    _descriptionTec.text = widget.healthPlanModel?.description ?? "";
    healthPlanTypeSelected = widget.healthPlanModel?.healthPlanType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar este convênio'),
      ),
      body: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        const Text('* Defina o gestor do Convênio'),
                        Row(
                          children: [
                            Expanded(
                              child: Obx(
                                  () => AppDropDownGeneric<HealthPlanTypeModel>(
                                        options: widget._profileController
                                            .healthPlanTypeList
                                            .toList(),
                                        selected: healthPlanTypeSelected,
                                        execute: (value) {
                                          healthPlanTypeSelected = value;
                                          setState(() {});
                                        },
                                        width: 150,
                                      )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppTextFormField(
                    label: '* Código do convênio de saúde.',
                    controller: _codeTec,
                    validator:
                        Validatorless.required('É informação obrigatório'),
                  ),
                  AppTextFormField(
                    label: 'Outras informações.',
                    controller: _descriptionTec,
                  ),
                  AppCalendarButton(
                    title: "Vencimento:",
                    getDate: () => widget._profileController.dateDueHealthPlan,
                    setDate: (value) =>
                        widget._profileController.dateDueHealthPlan = value,
                    isBirthDay: false,
                  ),
                  const SizedBox(height: 20),
                  widget.healthPlanModel?.id == null
                      ? Container()
                      : CheckboxListTile(
                          tileColor: _isDeleted ? Colors.red : null,
                          title: const Text("Apagar este convênio"),
                          onChanged: (value) {
                            setState(() {
                              _isDeleted = value!;
                            });
                          },
                          value: _isDeleted,
                        ),
                  ElevatedButton(
                    onPressed: () async {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        await widget._profileController.healthPlanUpdate(
                          healthPlanType: healthPlanTypeSelected!,
                          code: _codeTec.text,
                          description: _descriptionTec.text,
                          isDeleted: _isDeleted,
                        );
                        Get.back();
                      }
                    },
                    child: const Text('Salvar convênio.'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
