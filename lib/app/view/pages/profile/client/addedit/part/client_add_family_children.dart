import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/client/addedit/client_addedit_controller.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class ClientAddFamilyChildren extends StatefulWidget {
  final _clientAddEditController = Get.find<ClientAddEditController>();
  final bool isChildren;
  ClientAddFamilyChildren({
    Key? key,
    required this.isChildren,
  }) : super(key: key);

  @override
  State<ClientAddFamilyChildren> createState() =>
      _ClientAddFamilyChildrenState();
}

class _ClientAddFamilyChildrenState extends State<ClientAddFamilyChildren> {
  final _formKey = GlobalKey<FormState>();
  final _objectIdTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _objectIdTEC.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Adicionar apenas um id de envolvido'),
                AppTextFormField(
                  label: 'Informe um id',
                  controller: _objectIdTEC,
                  validator: Validatorless.required('id é obrigatório'),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    const SizedBox(
                      width: 50,
                    ),
                    TextButton(
                        onPressed: () async {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (formValid) {
                            await widget._clientAddEditController.familyUpdate(
                              id: _objectIdTEC.text,
                              isAdd: true,
                            );
                            Get.back();
                          }
                        },
                        child: const Text('Buscar')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
