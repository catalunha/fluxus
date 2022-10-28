import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/client/addedit/client_addedit_controller.dart';
import 'package:fluxus/app/view/pages/profile/client/addedit/part/client_add_family_children.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import 'package:fluxus/app/view/pages/profile/user/part/user_profile_photo.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class ClientAddEditPage extends StatefulWidget {
  const ClientAddEditPage({Key? key}) : super(key: key);

  @override
  State<ClientAddEditPage> createState() => _ClientAddEditPageState();
}

class _ClientAddEditPageState extends State<ClientAddEditPage> {
  final _clientAddEditController = Get.find<ClientAddEditController>();

//   @override
  final dateFormat = DateFormat('dd/MM/y');

  final _formKey = GlobalKey<FormState>();

  // final _nameTec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveProfile();
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
      body: FutureBuilder<void>(
          future: _clientAddEditController.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'Id: ${_clientAddEditController.profile?.id}',
                              style: const TextStyle(fontSize: 8),
                            ),
                            const SizedBox(height: 5),
                            AppTextFormField(
                              label: '* Seu nome completo.',
                              controller: _clientAddEditController.nameTec,
                              validator:
                                  Validatorless.required('Nome é obrigatório'),
                            ),
                            Obx(
                              () => CheckboxListTile(
                                title: const Text("* É do sexo feminimo ?"),
                                onChanged: (value) {
                                  // setState(() {
                                  //   _isFemale = value!;
                                  // });
                                  _clientAddEditController.isFemale =
                                      value ?? false;
                                },
                                value: _clientAddEditController.isFemale,
                              ),
                            ),
                            AppCalendarButton(
                              title: "* Data de nascimento.",
                              getDate: () =>
                                  _clientAddEditController.dateBirthday,
                              setDate: (value) =>
                                  _clientAddEditController.dateBirthday = value,
                            ),
                            const SizedBox(height: 5),
                            const Divider(color: Colors.green, height: 5),
                            const SizedBox(height: 5),
                            AppTextFormField(
                              label: 'Seu telefone mais acessível',
                              controller: _clientAddEditController.phoneTec,
                              mask: _clientAddEditController.maskPhone,
                            ),
                            AppTextFormField(
                              label: 'Seu email mais acessível',
                              controller: _clientAddEditController.emailTec,
                              validator:
                                  Validatorless.email('Não é email válido.'),
                            ),
                            AppTextFormField(
                              label: 'Seu CPF',
                              controller: _clientAddEditController.cpfTec,
                              mask: _clientAddEditController.maskCPF,
                              validator: Validatorless.cpf(
                                  'Este número não é CPF válido'),
                            ),
                            AppTextFormField(
                              label: 'O CEP do seu endereço.',
                              controller: _clientAddEditController.cepTec,
                              mask: _clientAddEditController.maskCEP,
                            ),
                            AppTextFormField(
                              label: 'O PLUSCODE do seu endereço.',
                              controller: _clientAddEditController.pluscodeTec,
                            ),
                            AppTextFormField(
                              label: 'Seu endereço completo.',
                              controller: _clientAddEditController.addressTec,
                            ),

                            // AppTextFormField(
                            //   label: 'O número de registro em seu conselho.',
                            //   controller: _clientAddEditController.registerTec,
                            // ),
                            AppTextFormField(
                              label: 'Uma breve descrição sobre você.',
                              controller:
                                  _clientAddEditController.descriptionTec,
                            ),
                            const SizedBox(height: 5),
                            UserProfilePhoto(
                              photoUrl: _clientAddEditController.profile?.photo,
                              setXFile: (value) =>
                                  _clientAddEditController.xfile = value,
                            ),
                            const SizedBox(height: 5),
                            // const Text('Suas especialidades'),
                            // expertiseList(),
                            const SizedBox(height: 5),
                            // const Text('Suas funcões'),
                            // officeList(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Seus convênios'),
                                IconButton(
                                    onPressed: () async {
                                      // await saveProfile();
                                      // await _clientAddEditController
                                      //     .healthPlanAdd();
                                      // await Get.toNamed(Routes.profileHealthPlan);
                                      var result = await saveProfile();
                                      if (result) {
                                        await _clientAddEditController
                                            .healthPlanAdd();
                                        setState(() {});
                                      } else {
                                        Get.snackbar(
                                          'Atenção',
                                          'Campos obrigatórios não foram preenchidos.',
                                          backgroundColor: Colors.red,
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.add))
                              ],
                            ),
                            healthPlanList(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Seu grupo familiar'),
                                IconButton(
                                  onPressed: () async {
                                    // await showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) =>
                                    //       ClientAddFamilyChildren(
                                    //           isChildren: false),
                                    // );
                                    var result = await saveProfile();
                                    if (result) {
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            ClientAddFamilyChildren(
                                                isChildren: false),
                                      );
                                      setState(() {});
                                    } else {
                                      Get.snackbar(
                                        'Atenção',
                                        'Campos obrigatórios não foram preenchidos.',
                                        backgroundColor: Colors.red,
                                      );
                                    }
                                  },
                                  icon: const Icon(Icons.add),
                                )
                              ],
                            ),
                            familyList(),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<bool> saveProfile() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      if (_clientAddEditController.dateBirthday == null) {
        return false;
      }
      await _clientAddEditController.append(
        name: _clientAddEditController.nameTec.text,
        email: _clientAddEditController.emailTec.text,
        description: _clientAddEditController.descriptionTec.text,
        phone: _clientAddEditController.maskPhone.getUnmaskedText(),
        cpf: _clientAddEditController.maskCPF.getUnmaskedText(),
        cep: _clientAddEditController.maskCEP.getUnmaskedText(),
        // phone: _clientAddEditController.phoneTec.text,
        // cep: _clientAddEditController.cepTec.text,
        // cpf: _clientAddEditController.cpfTec.text,
        address: _clientAddEditController.addressTec.text,
        pluscode: _clientAddEditController.pluscodeTec.text,
        register: _clientAddEditController.registerTec.text,
        isFemale: _clientAddEditController.isFemale,
      );
      return true;
    }
    return false;
  }

  Widget expertiseList() {
    if (_clientAddEditController.profile?.expertise != null) {
      return Column(
        children: [
          ..._clientAddEditController.profile!.expertise!
              .map((e) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextTitleValue(
                                title: 'Nome: ',
                                value: '${e.name}',
                              ),
                              AppTextTitleValue(
                                title: 'Descrição: ',
                                value: '${e.description}',
                              ),
                              AppTextTitleValue(
                                title: 'Id: ',
                                value: '${e.id}',
                              ),
                            ]),
                      ),
                    ),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }

  Widget officeList() {
    if (_clientAddEditController.profile?.office != null) {
      return Column(
        children: [
          ..._clientAddEditController.profile!.office!
              .map((e) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextTitleValue(
                                title: 'Nome: ',
                                value: '${e.name}',
                              ),
                              AppTextTitleValue(
                                title: 'Descrição: ',
                                value: '${e.description}',
                              ),
                              AppTextTitleValue(
                                title: 'Id: ',
                                value: '${e.id}',
                              ),
                            ]),
                      ),
                    ),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }

  Widget healthPlanList() {
    if (_clientAddEditController.profile?.healthPlan != null) {
      return Obx(() => Column(
            children: [
              ..._clientAddEditController.profile!.healthPlan!
                  .map((e) => Card(
                        child: Column(children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await saveProfile();
                                  await _clientAddEditController
                                      .healthPlanEdit(e.id!);
                                  // setState(() {});
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextTitleValue(
                                    title: 'Gestor: ',
                                    value: '${e.healthPlanType?.name}',
                                  ),
                                  AppTextTitleValue(
                                    title: 'Número: ',
                                    value: '${e.code}',
                                  ),
                                  AppTextTitleValue(
                                    title: 'Descrição: ',
                                    value: '${e.description}',
                                  ),
                                  AppTextTitleValue(
                                    title: 'Vencimento: ',
                                    value: e.due != null
                                        ? dateFormat.format(e.due!)
                                        : "...",
                                  ),
                                  AppTextTitleValue(
                                    title: 'Id: ',
                                    value: '${e.id}',
                                  ),
                                ],
                              )
                            ],
                          ),
                        ]),
                      ))
                  .toList()
            ],
          ));
    } else {
      return Container();
    }
  }

  Widget familyList() {
    if (_clientAddEditController.profile?.family != null) {
      return Obx(() => Column(
            children: [
              ..._clientAddEditController.profile!.family!
                  .map((e) => Card(
                        child: Column(children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await saveProfile();
                                  await _clientAddEditController.familyUpdate(
                                    id: e.id!,
                                    isAdd: false,
                                  );
                                  // setState(() {});
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextTitleValue(
                                    title: 'Nome: ',
                                    value: '${e.name}',
                                  ),
                                  AppTextTitleValue(
                                    title: 'Id: ',
                                    value: '${e.id}',
                                  ),
                                ],
                              )
                            ],
                          ),
                        ]),
                      ))
                  .toList()
            ],
          ));
    } else {
      return Container();
    }
  }
}
