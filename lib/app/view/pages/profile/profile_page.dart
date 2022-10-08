import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/profile/profile_controller.dart';
import 'package:fluxus/app/view/pages/profile/part/user_profile_photo.dart';
import 'package:fluxus/app/view/pages/utils/app_calendar_button.dart';
import 'package:fluxus/app/view/pages/utils/app_textformfield.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  final _userProfileController = Get.find<ProfileController>();

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
    // TODO: implement initState
    super.initState();
    _nameTec.text = widget._userProfileController.profile?.name ?? "";
    _phoneTec.text = widget._userProfileController.profile?.phone ?? "";
    _addressTec.text = widget._userProfileController.profile?.address ?? "";
    _cepTec.text = widget._userProfileController.profile?.cep ?? "";
    _pluscodeTec.text = widget._userProfileController.profile?.pluscode ?? "";
    _cpfTec.text = widget._userProfileController.profile?.cpf ?? "";
    _registerTec.text = widget._userProfileController.profile?.register ?? "";
    _descriptionTec.text =
        widget._userProfileController.profile?.description ?? "";
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
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
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
                  AppCalendarButton(),
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
                  ElevatedButton(
                    onPressed: () async {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        await widget._userProfileController.append(
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
                        Get.back();
                      }
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
}
