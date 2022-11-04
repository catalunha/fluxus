import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/profile/client/search/client_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';

class ClientSearchPage extends StatefulWidget {
  final _clientProfileController = Get.find<ClientSearchController>();
  ClientSearchPage({Key? key}) : super(key: key);

  @override
  State<ClientSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<ClientSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _nameContains = false;
  bool _cpfEqualTo = false;
  bool _phoneEqualTo = false;
  bool _birthday = false;
  final _nameContainsTEC = TextEditingController();
  final _cpfEqualToTEC = TextEditingController();
  final _phoneEqualToTEC = TextEditingController();

  @override
  void initState() {
    _nameContainsTEC.text = '';
    _cpfEqualToTEC.text = '';
    _phoneEqualToTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando pacientes'),
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
                        const Text('por Nome'),
                        Row(
                          children: [
                            Checkbox(
                              value: _nameContains,
                              onChanged: (value) {
                                setState(() {
                                  _nameContains = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Nome que contém',
                                controller: _nameContainsTEC,
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
                        const Text('por CPF'),
                        Row(
                          children: [
                            Checkbox(
                              value: _cpfEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _cpfEqualTo = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'CPF igual a',
                                controller: _cpfEqualToTEC,
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
                        const Text('por Telefone'),
                        Row(
                          children: [
                            Checkbox(
                              value: _phoneEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _phoneEqualTo = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'Telefone igual a',
                                controller: _phoneEqualToTEC,
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
                        const Text('por Data de nascimento'),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Checkbox(
                              value: _birthday,
                              onChanged: (value) {
                                setState(() {
                                  _birthday = value!;
                                });
                              },
                            ),
                            AppCalendarButton(
                              title: "Data de nascimento.",
                              getDate: () =>
                                  widget._clientProfileController.selectedDate,
                              setDate: (value) => widget
                                  ._clientProfileController
                                  .selectedDate = value,
                              isBirthDay: true,
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
            await widget._clientProfileController.search(
              nameContainsBool: _nameContains,
              nameContainsString: _nameContainsTEC.text,
              cpfEqualToBool: _cpfEqualTo,
              cpfEqualToString: _cpfEqualToTEC.text,
              phoneEqualToBool: _phoneEqualTo,
              phoneEqualToString: _phoneEqualToTEC.text,
              birthdayBool: _birthday,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
