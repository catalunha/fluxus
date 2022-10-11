import 'package:flutter/material.dart';
import 'package:fluxus/app/view/pages/user/profile/part/add_family_children.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import 'package:fluxus/app/view/controllers/user/profile/user_profile_controller.dart';
import 'package:fluxus/app/view/pages/user/profile/part/user_profile_photo.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  final _profileController = Get.find<UserProfileController>();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    print('+++ initState +++');
    super.initState();
    _nameTec.text = widget._profileController.profile?.name ?? "";
    _phoneTec.text = widget._profileController.profile?.phone ?? "";
    _addressTec.text = widget._profileController.profile?.address ?? "";
    _cepTec.text = widget._profileController.profile?.cep ?? "";
    _pluscodeTec.text = widget._profileController.profile?.pluscode ?? "";
    _cpfTec.text = widget._profileController.profile?.cpf ?? "";
    _registerTec.text = widget._profileController.profile?.register ?? "";
    _descriptionTec.text = widget._profileController.profile?.description ?? "";
    _isFemale = widget._profileController.profile?.isFemale ?? false;
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
                    getDate: () => widget._profileController.dateBirthday,
                    setDate: (value) =>
                        widget._profileController.dateBirthday = value,
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
                  UserProfilePhoto(),
                  const SizedBox(height: 5),
                  const Text('Suas especialidades'),
                  expertiseList(),
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
                            await widget._profileController.healthPlanAdd();
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
                      const Text('Seus familiares'),
                      IconButton(
                          onPressed: () async {
                            await saveProfile();
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AddFamilyChildren(isChildren: false),
                            );
                            setState(() {});
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  familyList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Crianças sob sua responsabilidade'),
                      IconButton(
                          onPressed: () async {
                            await saveProfile();
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AddFamilyChildren(isChildren: true),
                            );
                            setState(() {});
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  childrenList(),
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
                  //     //   await widget._profileController.append(
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
    if (widget._profileController.dateBirthday == null) {
      return false;
    }
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      await widget._profileController.append(
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
    if (widget._profileController.profile?.expertise != null) {
      return Column(
        children: [
          ...widget._profileController.profile!.expertise!
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
    if (widget._profileController.profile?.office != null) {
      return Column(
        children: [
          ...widget._profileController.profile!.office!
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
    if (widget._profileController.profile?.healthPlan != null) {
      return Column(
        children: [
          ...widget._profileController.profile!.healthPlan!
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await saveProfile();
                              await widget._profileController
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
                      //       await widget._profileController
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
    if (widget._profileController.profile?.family != null) {
      return Column(
        children: [
          ...widget._profileController.profile!.family!
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await saveProfile();
                              await widget._profileController
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
                      //       await widget._profileController
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
    if (widget._profileController.profile?.children != null) {
      return Column(
        children: [
          ...widget._profileController.profile!.children!
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await saveProfile();
                              await widget._profileController
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
                      //       await widget._profileController
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
