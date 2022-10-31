import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/view/controllers/profile/view/client_view_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_link_text.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ClientViewPage extends StatelessWidget {
  final clientViewController = Get.find<ClientViewController>();
  ClientViewPage({super.key});
  final dateFormat = DateFormat('dd/MM/y');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados desta pessoa')),
      body: FutureBuilder(
          future: clientViewController.getProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              ProfileModel profileModel = snapshot.data!;
              String dataAge = '';
              if (profileModel.birthday != null) {
                DateDuration duration;
                duration = AgeCalculator.age(profileModel.birthday!,
                    today: DateTime.now());
                dataAge =
                    '${duration.years} a, ${duration.months} m, ${duration.days} d';
              }
              var maskPhone = MaskTextInputFormatter(
                initialText: profileModel.phone,
                mask: '(##) # ####-####',
                filter: {"#": RegExp(r'[0-9]')},
                type: MaskAutoCompletionType.lazy,
              );

              var maskCPF = MaskTextInputFormatter(
                  initialText: profileModel.cpf,
                  mask: '###.###.###-##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy);
              var maskCEP = MaskTextInputFormatter(
                  initialText: profileModel.cep,
                  mask: '#####-###',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy);
              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        fotoWidget(profileModel),
                        AppTextTitleValue(
                          title: 'Id: ',
                          value: profileModel.id,
                          inColumn: true,
                        ),
                        if (profileModel.name != null)
                          AppTextTitleValue(
                            title: 'Nome: ',
                            value: profileModel.name,
                            inColumn: true,
                          ),
                        if (profileModel.isFemale != null)
                          AppTextTitleValue(
                            title: 'Sexo: ',
                            value: profileModel.isFemale != null &&
                                    profileModel.isFemale!
                                ? "Feminino"
                                : "Masculino",
                            inColumn: true,
                          ),
                        if (profileModel.birthday != null)
                          AppTextTitleValue(
                            title: 'Data de nascimento: ',
                            value: profileModel.birthday != null
                                ? dateFormat.format(profileModel.birthday!)
                                : "...",
                            inColumn: true,
                          ),
                        if (dataAge.isNotEmpty)
                          AppTextTitleValue(
                            title: 'Idade atual: ',
                            value: dataAge,
                            inColumn: true,
                          ),
                        if (maskPhone.getMaskedText().isNotEmpty)
                          AppTextTitleValue(
                            title: 'Telefone: ',
                            value: maskPhone.getMaskedText(),
                            inColumn: true,
                          ),
                        if (maskCPF.getMaskedText().isNotEmpty)
                          AppTextTitleValue(
                            title: 'CPF: ',
                            value: maskCPF.getMaskedText(),
                            inColumn: true,
                          ),
                        if (maskCEP.getMaskedText().isNotEmpty)
                          AppTextTitleValue(
                            title: 'CEP: ',
                            value: maskCEP.getMaskedText(),
                            inColumn: true,
                          ),
                        if (profileModel.address != null)
                          AppTextTitleValue(
                            title: 'Endereço: ',
                            value: profileModel.address,
                            inColumn: true,
                          ),
                        if (profileModel.pluscode != null)
                          const Text(
                            'PlusCode: ',
                            style: TextStyle(color: Colors.blueGrey),
                          ),
                        if (profileModel.pluscode != null)
                          AppLinkText(
                            url: profileModel.pluscode,
                            text: profileModel.pluscode,
                          ),
                        if (profileModel.description != null)
                          AppTextTitleValue(
                            title: 'Descrição: ',
                            value: profileModel.description,
                            inColumn: true,
                          ),
                        familyList(profileModel),
                        healthPlanList(profileModel),
                        officeList(profileModel),
                        expertiseList(profileModel),
                        procedureList(profileModel),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }

  copy(String text) async {
    Get.snackbar(text, 'Ids copiados.',
        // backgroundColor: Colors.yellow,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1));
    await Clipboard.setData(ClipboardData(text: text));
  }

  Widget familyList(ProfileModel profileModel) {
    if (profileModel.family != null && profileModel.family!.isNotEmpty) {
      var maskPhone = MaskTextInputFormatter(
        initialText: profileModel.phone,
        mask: '(##) # ####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
      );
      return Column(
        children: [
          const Text(
            'Familiares: ',
            style: TextStyle(color: Colors.blueGrey),
          ),
          ...profileModel.family!
              .map((e) => Card(
                    child: SizedBox(
                      width: 300,
                      child: Row(
                        children: [
                          e.photo == null
                              ? const SizedBox()
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    e.photo!,
                                    height: 70,
                                    width: 70,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Container();
                                    },
                                  ),
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextTitleValue(
                                title: 'Nome: ',
                                value: '${e.name}',
                              ),
                              AppTextTitleValue(
                                title: 'Fone: ',
                                value: maskPhone.getMaskedText(),
                              ),
                              AppTextTitleValue(
                                title: 'Id: ',
                                value: '${e.id}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList()
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget healthPlanList(ProfileModel profileModel) {
    if (profileModel.healthPlan != null &&
        profileModel.healthPlan!.isNotEmpty) {
      return Column(
        children: [
          const Text(
            'Convênios: ',
            style: TextStyle(color: Colors.blueGrey),
          ),
          ...profileModel.healthPlan!
              .map((e) => InkWell(
                    child: Card(
                      child: SizedBox(
                        width: 300,
                        child: Column(
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
                        ),
                      ),
                    ),
                    onTap: () => copy('${profileModel.id!} ${e.id!}'),
                  ))
              .toList()
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget expertiseList(ProfileModel profileModel) {
    if (profileModel.expertise != null && profileModel.expertise!.isNotEmpty) {
      return Column(
        children: [
          const Text(
            'Especialidades: ',
            style: TextStyle(color: Colors.blueGrey),
          ),
          ...profileModel.expertise!
              .map((e) => InkWell(
                    child: Card(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextTitleValue(
                              title: 'Gestor: ',
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
                          ],
                        ),
                      ),
                    ),
                    onTap: () => copy('${profileModel.id!} ${e.id!}'),
                  ))
              .toList()
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget procedureList(ProfileModel profileModel) {
    if (profileModel.procedure != null && profileModel.procedure!.isNotEmpty) {
      return Column(
        children: [
          const Text(
            'Procedimentos: ',
            style: TextStyle(color: Colors.blueGrey),
          ),
          ...profileModel.procedure!
              .map((e) => InkWell(
                    child: Card(
                      child: SizedBox(
                        width: 300,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextTitleValue(
                                title: 'Code: ',
                                value: '${e.code}',
                              ),
                              AppTextTitleValue(
                                title: 'Nome: ',
                                value: '${e.name}',
                              ),
                              AppTextTitleValue(
                                title: 'id: ',
                                value: '${e.id}',
                              ),
                            ]),
                      ),
                    ),
                    onTap: () => copy('${profileModel.id!} ${e.id!}'),
                  ))
              .toList()
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget officeList(ProfileModel profileModel) {
    if (profileModel.office != null && profileModel.office!.isNotEmpty) {
      return Column(
        children: [
          const Text(
            'Funções: ',
            style: TextStyle(color: Colors.blueGrey),
          ),
          ...profileModel.office!
              .map((e) => InkWell(
                    child: Card(
                      child: SizedBox(
                        width: 300,
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
                    onTap: () => copy('${profileModel.id!} ${e.id!}'),
                  ))
              .toList()
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget fotoWidget(ProfileModel profile) {
    if (profile.photo != null) {
      return Column(
        children: [
          const Text(
            'Foto: ',
            style: TextStyle(color: Colors.blueGrey),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              profile.photo!,
              height: 100,
              width: 100,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container();
              },
            ),
          ),
          Text('${profile.id}'),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
