import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/view/controllers/client/view/client_view_controller.dart';
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
                        const Text(
                          'Foto: ',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        profileModel.photo == null
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Foto indisponível',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  profileModel.photo!,
                                  height: 100,
                                  width: 100,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container();
                                  },
                                ),
                              ),
                        Text('${profileModel.id}'),
                        AppTextTitleValue(
                          title: 'Nome: ',
                          value: profileModel.name,
                          inColumn: true,
                        ),
                        AppTextTitleValue(
                          title: 'Sexo: ',
                          value: profileModel.isFemale != null &&
                                  profileModel.isFemale!
                              ? "Feminino"
                              : "Masculino",
                          inColumn: true,
                        ),
                        AppTextTitleValue(
                          title: 'Data de nascimento: ',
                          value: profileModel.birthday != null
                              ? dateFormat.format(profileModel.birthday!)
                              : "...",
                          inColumn: true,
                        ),
                        AppTextTitleValue(
                          title: 'Idade atual: ',
                          value: dataAge,
                          inColumn: true,
                        ),
                        AppTextTitleValue(
                          title: 'Telefone: ',
                          value: maskPhone.getMaskedText(),
                          inColumn: true,
                        ),
                        AppTextTitleValue(
                          title: 'CPF: ',
                          value: maskCPF.getMaskedText(),
                          inColumn: true,
                        ),
                        AppTextTitleValue(
                          title: 'CEP: ',
                          value: maskCEP.getMaskedText(),
                          inColumn: true,
                        ),
                        AppTextTitleValue(
                          title: 'Endereço: ',
                          value: profileModel.address,
                          inColumn: true,
                        ),
                        const Text(
                          'PlusCode: ',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        AppLinkText(
                          url: profileModel.pluscode,
                          text: profileModel.pluscode,
                        ),
                        AppTextTitleValue(
                          title: 'Descrição: ',
                          value: profileModel.description,
                          inColumn: true,
                        ),
                        const Text(
                          'Familiares: ',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        familyList(profileModel),
                        const Text(
                          'Convênios: ',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        healthPlanList(profileModel),
                        const Text(
                          'Ocupações: ',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        officeList(profileModel),
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
    Get.snackbar(
      text,
      'Ids copiados.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
    );
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
      return const Text('...');
    }
  }

  Widget healthPlanList(ProfileModel profileModel) {
    if (profileModel.healthPlan != null &&
        profileModel.healthPlan!.isNotEmpty) {
      return Column(
        children: [
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
      return const Text('...');
    }
  }

  Widget officeList(ProfileModel profileModel) {
    if (profileModel.office != null && profileModel.office!.isNotEmpty) {
      return Column(
        children: [
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
      return Container();
    }
  }
}
