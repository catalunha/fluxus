import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/profile/profile_controller.dart';
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
  // final _descriptionTec = TextEditingController();
  final _phoneTec = TextEditingController();
  // final _unitTec = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTec.text = widget._userProfileController.userProfile?.name ?? "";
    // _descriptionTec.text =
    //     widget._userProfileController.userProfile?.description ?? "";
    _phoneTec.text = widget._userProfileController.userProfile?.phone ?? "";
    // _unitTec.text = widget._userProfileController.userProfile?.unit ?? "";
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
                    label: 'Seu nome.',
                    controller: _nameTec,
                    validator: Validatorless.required('Nome é obrigatório'),
                  ),
                  // AppTextFormField(
                  //   label: 'Uma breve descrição sobre você.',
                  //   controller: _descriptionTec,
                  // ),
                  AppTextFormField(
                    label: 'Seu telefone com DDD.',
                    controller: _phoneTec,
                  ),
                  // AppTextFormField(
                  //   label: 'Sua unidade.',
                  //   controller: _unitTec,
                  // ),
                  // UserProfilePhoto(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (formValid) {
                        await widget._userProfileController.append(
                          name: _nameTec.text,
                          // description: _descriptionTec.text,
                          phone: _phoneTec.text,
                          // unit: _unitTec.text,
                        );
                        Get.back();
                      }
                    },
                    child: const Text('Salvar atualização.'),
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