import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/view/controllers/profile/client/addedit/client_addedit_controller.dart';
import 'package:fluxus/app/view/pages/profile/client/addedit/client_health_plan_addedit_page.dart';
import 'package:fluxus/app/view/pages/utils/app_dialog_add_ids.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

import 'package:fluxus/app/view/pages/profile/user/part/user_profile_photo.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';

class ClientAddEditPage extends StatefulWidget {
  final _clientAddEditController = Get.find<ClientAddEditController>();
  ClientAddEditPage({Key? key}) : super(key: key);

  @override
  State<ClientAddEditPage> createState() => _ClientAddEditPageState();
}

class _ClientAddEditPageState extends State<ClientAddEditPage> {
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
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Id: ${widget._clientAddEditController.profile?.id}',
                      style: const TextStyle(fontSize: 8),
                    ),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      label: '* Seu nome completo.',
                      controller: widget._clientAddEditController.nameTec,
                      validator: Validatorless.required('Nome é obrigatório'),
                    ),
                    Obx(
                      () => CheckboxListTile(
                        title: const Text("* É do sexo feminimo ?"),
                        onChanged: (value) {
                          // setState(() {
                          //   _isFemale = value!;
                          // });
                          widget._clientAddEditController.isFemale =
                              value ?? false;
                        },
                        value: widget._clientAddEditController.isFemale,
                      ),
                    ),
                    AppCalendarButton(
                      title: "* Data de nascimento.",
                      getDate: () =>
                          widget._clientAddEditController.dateBirthday,
                      setDate: (value) =>
                          widget._clientAddEditController.dateBirthday = value,
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Colors.green, height: 5),
                    const SizedBox(height: 5),
                    AppTextFormField(
                      label: 'Seu telefone mais acessível',
                      controller: widget._clientAddEditController.phoneTec,
                      mask: widget._clientAddEditController.maskPhone,
                    ),
                    AppTextFormField(
                      label: 'Seu email mais acessível',
                      controller: widget._clientAddEditController.emailTec,
                      validator: Validatorless.email('Não é email válido.'),
                    ),
                    AppTextFormField(
                      label: 'Seu CPF',
                      controller: widget._clientAddEditController.cpfTec,
                      mask: widget._clientAddEditController.maskCPF,
                      validator:
                          Validatorless.cpf('Este número não é CPF válido'),
                    ),
                    AppTextFormField(
                      label: 'O CEP do seu endereço.',
                      controller: widget._clientAddEditController.cepTec,
                      mask: widget._clientAddEditController.maskCEP,
                    ),
                    AppTextFormField(
                      label: 'O PLUSCODE do seu endereço.',
                      controller: widget._clientAddEditController.pluscodeTec,
                    ),
                    AppTextFormField(
                      label: 'Seu endereço completo.',
                      controller: widget._clientAddEditController.addressTec,
                    ),

                    // AppTextFormField(
                    //   label: 'O número de registro em seu conselho.',
                    //   controller: widget._clientAddEditController.registerTec,
                    // ),
                    AppTextFormField(
                      label: 'Uma breve descrição sobre você.',
                      controller:
                          widget._clientAddEditController.descriptionTec,
                    ),
                    const SizedBox(height: 5),
                    Obx(() => UserProfilePhoto(
                          photoUrl:
                              widget._clientAddEditController.profile?.photo,
                          setXFile: (value) =>
                              widget._clientAddEditController.xfile = value,
                        )),
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
                              HealthPlanModel? res = await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  widget._clientAddEditController
                                      .dateDueHealthPlan = null;
                                  return ClientHealthPlanAddEditPage(
                                      healthPlanModel: HealthPlanModel());
                                },
                              );
                              if (res != null) {
                                // await widget._eventAddEditController
                                //     .addAttendance(res);
                                await widget._clientAddEditController
                                    .addHealthPlan(healthPlanTemp: res);
                              }
                              // await saveProfile();
                              // await widget._clientAddEditController
                              //     .healthPlanAdd();
                              // await Get.toNamed(Routes.profileHealthPlan);
                              // var result = await saveProfile();
                              // if (result) {
                              // await widget._clientAddEditController
                              //     .healthPlanPageAdd();
                              setState(() {});
                              // } else {
                              //   Get.snackbar(
                              //     'Atenção',
                              //     'Campos obrigatórios não foram preenchidos.',
                              //     backgroundColor: Colors.red,
                              //   );
                              // }
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                    Obx(() => healthPlanList()),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Seu grupo familiar'),
                        IconButton(
                          onPressed: () async {
                            // var result = await saveProfile();
                            // if (result) {
                            String? res = await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return const AppDialogAddIds(
                                  title: 'Informe o Id do familiar',
                                );
                              },
                            );
                            if (res != null) {
                              await widget._clientAddEditController.addFamily(
                                res,
                              );
                            }
                            setState(() {});
                            // } else {
                            //   Get.snackbar(
                            //     'Atenção',
                            //     'Campos obrigatórios não foram preenchidos.',
                            //     backgroundColor: Colors.red,
                            //   );
                            // }
                          },
                          icon: const Icon(Icons.add),
                        )
                      ],
                    ),
                    Obx(() => familyList()),

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

  Future<bool> saveProfile() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      if (widget._clientAddEditController.dateBirthday == null) {
        return false;
      }
      await widget._clientAddEditController.append(
        name: widget._clientAddEditController.nameTec.text,
        email: widget._clientAddEditController.emailTec.text,
        description: widget._clientAddEditController.descriptionTec.text,
        phone: widget._clientAddEditController.maskPhone.getUnmaskedText(),
        cpf: widget._clientAddEditController.maskCPF.getUnmaskedText(),
        cep: widget._clientAddEditController.maskCEP.getUnmaskedText(),
        // phone: widget._clientAddEditController.phoneTec.text,
        // cep: widget._clientAddEditController.cepTec.text,
        // cpf: widget._clientAddEditController.cpfTec.text,
        address: widget._clientAddEditController.addressTec.text,
        pluscode: widget._clientAddEditController.pluscodeTec.text,
        register: widget._clientAddEditController.registerTec.text,
        isFemale: widget._clientAddEditController.isFemale,
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
    if (widget._clientAddEditController.healthPlanList.isNotEmpty) {
      return Column(
        children: [
          ...widget._clientAddEditController.healthPlanList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // await saveProfile();
                                  HealthPlanModel? res = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      widget._clientAddEditController
                                          .dateDueHealthPlan = e.due;
                                      return ClientHealthPlanAddEditPage(
                                          healthPlanModel: e);
                                    },
                                  );
                                  if (res != null) {
                                    // await widget._eventAddEditController
                                    //     .addAttendance(res);
                                    await widget._clientAddEditController
                                        .addHealthPlan(healthPlanTemp: res);
                                  }

                                  // await widget._clientAddEditController
                                  //     .healthPlanPageEdit(e.id!);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  // await saveEvent();
                                  await widget._clientAddEditController
                                      .removeHealthPlan(e.id!);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                            ],
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
      );
    } else {
      return Container();
    }
  }

  Widget familyList() {
    if (widget._clientAddEditController.profileList.isNotEmpty) {
      return Column(
        children: [
          ...widget._clientAddEditController.profileList
              .map((e) => Card(
                    child: Column(children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              // await saveProfile();
                              await widget._clientAddEditController
                                  .removeFamily(e.id!);
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
      );
    } else {
      return Container();
    }
  }
}
