import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/evolution/search/evolution_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';
import 'package:get/get.dart';

class EvolutionSearchPage extends StatefulWidget {
  final _evolutionSearchController = Get.find<EvolutionSearchController>();
  EvolutionSearchPage({Key? key}) : super(key: key);

  @override
  State<EvolutionSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<EvolutionSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isArchived = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando evoluções'),
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
                        const Text('por Arquivadas'),
                        Row(
                          children: [
                            Checkbox(
                              value: _isArchived,
                              onChanged: (value) {
                                setState(() {
                                  _isArchived = value!;
                                });
                              },
                            ),
                            const Text('Listar evoluções arquivadas')
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       const Text('por CPF'),
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _cpfEqualTo,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _cpfEqualTo = value!;
                  //               });
                  //             },
                  //           ),
                  //           Expanded(
                  //             child: AppTextFormField(
                  //               label: 'CPF igual a',
                  //               controller: _cpfEqualToTEC,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Card(
                  //   child: Column(
                  //     children: [
                  //       const Text('por Telefone'),
                  //       Row(
                  //         children: [
                  //           Checkbox(
                  //             value: _phoneEqualTo,
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 _phoneEqualTo = value!;
                  //               });
                  //             },
                  //           ),
                  //           Expanded(
                  //             child: AppTextFormField(
                  //               label: 'Telefone igual a',
                  //               controller: _phoneEqualToTEC,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                  //                 widget._evaluationController.selectedDate,
                  //             setDate: (value) =>
                  //                 widget._evaluationController.selectedDate = value,
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
            await widget._evolutionSearchController.search(
              isArchived: _isArchived,
              // nameContainsString: _nameContainsTEC.text,
              // cpfEqualToBool: _cpfEqualTo,
              // cpfEqualToString: _cpfEqualToTEC.text,
              // phoneEqualToBool: _phoneEqualTo,
              // phoneEqualToString: _phoneEqualToTEC.text,
              // birthdayBool: _birthday,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
