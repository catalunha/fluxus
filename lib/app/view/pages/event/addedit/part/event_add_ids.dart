import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class EventAddIds extends StatefulWidget {
  // final _clientAddEditController = Get.find<ClientAddEditController>();
  // final bool isChildren;
  final String title;
  final String formFieldLabel;
  const EventAddIds({
    Key? key,
    required this.title,
    this.formFieldLabel = '',
  }) : super(key: key);

  @override
  State<EventAddIds> createState() => _EventAddIdsState();
}

class _EventAddIdsState extends State<EventAddIds> {
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
                Text(widget.title),
                AppTextFormField(
                  label: widget.formFieldLabel,
                  controller: _objectIdTEC,
                  validator: Validatorless.required('ids são obrigatórios'),
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
                          // final formValid =
                          //     _formKey.currentState?.validate() ?? false;
                          // if (formValid) {
                          //   await widget._clientAddEditController.familyUpdate(
                          //     id: _objectIdTEC.text,
                          //     isAdd: true,
                          //   );
                          //   Get.back();
                          // }
                          Get.back(result: _objectIdTEC.text);
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
