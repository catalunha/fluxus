import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/client/addedit/client_addedit_controller.dart';
import 'package:fluxus/app/view/pages/client/addedit/part/client_add_family_children.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import 'package:fluxus/app/view/pages/user/profile/part/user_profile_photo.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class ClientAddEditPage extends StatefulWidget {
  ClientAddEditPage({Key? key}) : super(key: key);
  final _clientAddEditController = Get.find<ClientAddEditController>();

  @override
  _ClientAddEditPageState createState() => _ClientAddEditPageState();
}

class _ClientAddEditPageState extends State<ClientAddEditPage> {
  final dateFormat = DateFormat('dd/MM/y');

  final _formKey = GlobalKey<FormState>();
  final _nameTec = TextEditingController();
  final _phoneTec = TextEditingController();
  final _addressTec = TextEditingController();
  final _cepTec = TextEditingController();
  final _pluscodeTec = TextEditingController();
  final _cpfTec = TextEditingController();
  final _registerTec = TextEditingController();
  final _descriptionTec = TextEditingController();
  bool _isFemale = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => yourFunction(context));
    super.initState();
  }

  Future<void> yourFunction(BuildContext context) async {
    await widget._clientAddEditController.getProfile();
    _nameTec.text = widget._clientAddEditController.profile?.name ?? "";
    _phoneTec.text = widget._clientAddEditController.profile?.phone ?? "";
    _addressTec.text = widget._clientAddEditController.profile?.address ?? "";
    _cepTec.text = widget._clientAddEditController.profile?.cep ?? "";
    _pluscodeTec.text = widget._clientAddEditController.profile?.pluscode ?? "";
    _cpfTec.text = widget._clientAddEditController.profile?.cpf ?? "";
    _registerTec.text = widget._clientAddEditController.profile?.register ?? "";
    _descriptionTec.text =
        widget._clientAddEditController.profile?.description ?? "";
    _isFemale = widget._clientAddEditController.profile?.isFemale ?? true;
    setState(() {});
  }

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
      body: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  AppTextFormField(
                    label: '* Seu nome completo.',
                    controller: _nameTec,
                    validator: Validatorless.required('Nome é obrigatório'),
                  ),
                  CheckboxListTile(
                    title: const Text("* É do sexo feminimo ?"),
                    onChanged: (value) {
                      setState(() {
                        _isFemale = value!;
                      });
                    },
                    value: _isFemale,
                  ),
                  AppCalendarButton(
                    title: "* Data de nascimento.",
                    getDate: () => widget._clientAddEditController.dateBirthday,
                    setDate: (value) =>
                        widget._clientAddEditController.dateBirthday = value,
                  ),
                  const SizedBox(height: 5),
                  const Divider(color: Colors.green, height: 5),
                  const SizedBox(height: 5),
                  AppTextFormField(
                    label: 'Seu telefone. Formato DDDNÚMERO.',
                    controller: _phoneTec,
                    validator: Validatorless.number('Informe apenas numeros'),
                  ),
                  AppTextFormField(
                    label: 'Seu CPF. Apenas números.',
                    controller: _cpfTec,
                    validator:
                        Validatorless.cpf('Este número não é CPF válido'),
                  ),
                  AppTextFormField(
                    label: 'Seu endereço completo.',
                    controller: _addressTec,
                  ),
                  AppTextFormField(
                    label: 'O CEP do seu endereço.',
                    controller: _cepTec,
                  ),
                  AppTextFormField(
                    label: 'O PLUSCODE do seu endereço.',
                    controller: _pluscodeTec,
                  ),
                  AppTextFormField(
                    label: 'O número de registro em seu conselho.',
                    controller: _registerTec,
                  ),
                  AppTextFormField(
                    label: 'Uma breve descrição sobre você.',
                    controller: _descriptionTec,
                  ),
                  const SizedBox(height: 5),
                  UserProfilePhoto(
                    photoUrl: widget._clientAddEditController.profile?.photo,
                    setXFile: (value) =>
                        widget._clientAddEditController.xfile = value,
                  ),
                  const SizedBox(height: 5),
                  // const Text('Suas especialidades'),
                  // expertiseList(),
                  const SizedBox(height: 5),
                  const Text('Suas funcões'),
                  officeList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Seus convênios'),
                      IconButton(
                          onPressed: () async {
                            await saveProfile();
                            await widget._clientAddEditController
                                .healthPlanAdd();
                            // await Get.toNamed(Routes.profileHealthPlan);
                            setState(() {});
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
                          await saveProfile();
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                ClientAddFamilyChildren(isChildren: false),
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                  familyList(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Text('Crianças sob sua responsabilidade'),
                  //     IconButton(
                  //         onPressed: () async {
                  //           await saveProfile();
                  //           await showDialog(
                  //             context: context,
                  //             builder: (BuildContext context) =>
                  //                 AddFamilyChildren(isChildren: true),
                  //           );
                  //           setState(() {});
                  //         },
                  //         icon: const Icon(Icons.add))
                  //   ],
                  // ),
                  // childrenList(),
                  const SizedBox(height: 70),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     var result = await saveProfile();
                  //     if (result) {
                  //       Get.back();
                  //     }
                  //     // final formValid =
                  //     //     _formKey.currentState?.validate() ?? false;
                  //     // if (formValid) {
                  //     //   await widget._clientAddEditController.append(
                  //     //     name: _nameTec.text,
                  //     //     description: _descriptionTec.text,
                  //     //     phone: _phoneTec.text,
                  //     //     address: _addressTec.text,
                  //     //     cep: _cepTec.text,
                  //     //     pluscode: _pluscodeTec.text,
                  //     //     cpf: _cpfTec.text,
                  //     //     register: _registerTec.text,
                  //     //     isFemale: _isFemale,
                  //     //   );
                  //     //   Get.back();
                  //     // }
                  //   },
                  //   child: const Text('Salvar perfil.'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> saveProfile() async {
    if (widget._clientAddEditController.dateBirthday == null) {
      return false;
    }
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      await widget._clientAddEditController.append(
        name: _nameTec.text,
        description: _descriptionTec.text,
        phone: _phoneTec.text,
        address: _addressTec.text,
        cep: _cepTec.text,
        pluscode: _pluscodeTec.text,
        cpf: _cpfTec.text,
        register: _registerTec.text,
        isFemale: _isFemale,
      );
      return true;
    }
    return false;
  }

  Widget expertiseList() {
    if (widget._clientAddEditController.profile?.expertise != null) {
      return Column(
        children: [
          ...widget._clientAddEditController.profile!.expertise!
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
                                title: 'id: ',
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
    if (widget._clientAddEditController.profile?.office != null) {
      return Column(
        children: [
          ...widget._clientAddEditController.profile!.office!
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
                                title: 'id: ',
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
    if (widget._clientAddEditController.profile?.healthPlan != null) {
      return Column(
        children: [
          ...widget._clientAddEditController.profile!.healthPlan!
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await saveProfile();
                              await widget._clientAddEditController
                                  .healthPlanEdit(e.id!);
                              setState(() {});
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
                                title: 'id: ',
                                value: '${e.id}',
                              ),
                            ],
                          )
                        ],
                      ),
                      // ListTile(
                      //   title: Text(e.id ?? '...'),
                      //   subtitle: Text(e.description ?? '...'),
                      //   trailing: IconButton(
                      //     onPressed: () async {
                      //       await saveProfile();
                      //       await widget._clientAddEditController
                      //           .healthPlanEdit(e.id!);
                      //       setState(() {});
                      //     },
                      //     icon: const Icon(Icons.edit),
                      //   ),
                      // ),
                    ]),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }

  Widget familyList() {
    if (widget._clientAddEditController.profile?.family != null) {
      return Column(
        children: [
          ...widget._clientAddEditController.profile!.family!
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await saveProfile();
                              await widget._clientAddEditController
                                  .familyChildrenUpdate(
                                id: e.id!,
                                isChildren: false,
                                isAdd: false,
                              );
                              setState(() {});
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
                                title: 'id: ',
                                value: '${e.id}',
                              ),
                            ],
                          )
                        ],
                      ),
                      // ListTile(
                      //   title: Text(e.id ?? '...'),
                      //   subtitle: Text(e.description ?? '...'),
                      //   trailing: IconButton(
                      //     onPressed: () async {
                      //       await saveProfile();
                      //       await widget._clientAddEditController
                      //           .healthPlanEdit(e.id!);
                      //       setState(() {});
                      //     },
                      //     icon: const Icon(Icons.edit),
                      //   ),
                      // ),
                    ]),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }

  Widget childrenList() {
    if (widget._clientAddEditController.profile?.children != null) {
      return Column(
        children: [
          ...widget._clientAddEditController.profile!.children!
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await saveProfile();
                              await widget._clientAddEditController
                                  .familyChildrenUpdate(
                                id: e.id!,
                                isChildren: true,
                                isAdd: false,
                              );
                              setState(() {});
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
                                title: 'id: ',
                                value: '${e.id}',
                              ),
                            ],
                          )
                        ],
                      ),
                      // ListTile(
                      //   title: Text(e.id ?? '...'),
                      //   subtitle: Text(e.description ?? '...'),
                      //   trailing: IconButton(
                      //     onPressed: () async {
                      //       await saveProfile();
                      //       await widget._clientAddEditController
                      //           .healthPlanEdit(e.id!);
                      //       setState(() {});
                      //     },
                      //     icon: const Icon(Icons.edit),
                      //   ),
                      // ),
                    ]),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }
}
