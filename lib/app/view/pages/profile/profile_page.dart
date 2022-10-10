import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/profile/profile_controller.dart';
import 'package:fluxus/app/view/pages/profile/part/user_profile_photo.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  final _profileController = Get.find<ProfileController>();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
      ),
      body: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextFormField(
                    label: '* Seu nome.',
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
                    title: "Data de nascimento.",
                    getDate: () => widget._profileController.selectedDate,
                    setDate: (value) =>
                        widget._profileController.selectedDate = value,
                  ),
                  const Divider(
                    color: Colors.green,
                    height: 5,
                  ),
                  AppTextFormField(
                    label: 'Seu telefone com DDD.',
                    controller: _phoneTec,
                  ),
                  AppTextFormField(
                    label: 'Seu CPF. Apenas numeros.',
                    controller: _cpfTec,
                    validator: Validatorless.cpf('Número não é CPF válido'),
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
                  const SizedBox(height: 20),
                  UserProfilePhoto(),
                  const SizedBox(height: 20),
                  const Text('Suas especialidades'),
                  expertiseList(),
                  const SizedBox(height: 20),
                  const Text('Suas funcões'),
                  officeList(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Seus planos de saúde'),
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var result = await saveProfile();
                      if (result) {
                        Get.back();
                      }
                      // final formValid =
                      //     _formKey.currentState?.validate() ?? false;
                      // if (formValid) {
                      //   await widget._profileController.append(
                      //     name: _nameTec.text,
                      //     description: _descriptionTec.text,
                      //     phone: _phoneTec.text,
                      //     address: _addressTec.text,
                      //     cep: _cepTec.text,
                      //     pluscode: _pluscodeTec.text,
                      //     cpf: _cpfTec.text,
                      //     register: _registerTec.text,
                      //     isFemale: _isFemale,
                      //   );
                      //   Get.back();
                      // }
                    },
                    child: const Text('Salvar perfil.'),
                  ),
                ],
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
              .map((e) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Text(e.name ?? '...'),
                        Text(e.code ?? '...'),
                        Text(e.description ?? '...'),
                      ]),
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
              .map((e) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Text(e.name ?? '...'),
                        Text(e.description ?? '...'),
                      ]),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        ListTile(
                          title: Text(e.id ?? '...'),
                          subtitle: Text(e.description ?? '...'),
                          trailing: IconButton(
                            onPressed: () async {
                              await saveProfile();
                              await widget._profileController
                                  .healthPlanEdit(e.id!);
                              setState(() {});
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ]),
                    ),
                  ))
              .toList()
        ],
      );
    } else {
      return Container();
    }
  }
}
