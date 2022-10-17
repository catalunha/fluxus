import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/health_plan_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HealthPlanCard extends StatelessWidget {
  // final _clientProfileController = Get.find<HealthPlanController>();

  final HealthPlanModel healthPlanModel;
  const HealthPlanCard({Key? key, required this.healthPlanModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                child: Column(
                  children: [
                    healthPlanModel.profile?.photo != null &&
                            healthPlanModel.profile!.photo!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              healthPlanModel.profile!.photo!,
                              height: 58,
                              width: 58,
                            ),
                          )
                        : const SizedBox(
                            height: 58,
                            width: 58,
                            child: Icon(Icons.person_outline),
                          ),
                    Text(
                      '${healthPlanModel.profile?.id}',
                      style: const TextStyle(fontSize: 8),
                    ),
                  ],
                ),
                onTap: () => copy(healthPlanModel.profile!.id!),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Id: ${healthPlanModel.id}',
                    style: const TextStyle(fontSize: 8),
                  ),
                  AppTextTitleValue(
                    title: 'Tipo: ',
                    value: '${healthPlanModel.healthPlanType?.name}',
                  ),
                  AppTextTitleValue(
                    title: 'Código: ',
                    value: '${healthPlanModel.code}',
                  ),
                  AppTextTitleValue(
                    title: 'Descrição: ',
                    value: '${healthPlanModel.description}',
                  ),
                  AppTextTitleValue(
                    title: 'DataNasc: ',
                    value: healthPlanModel.due != null
                        ? formatter.format(healthPlanModel.due!)
                        : "...",
                  ),
                  AppTextTitleValue(
                    title: 'Nome do conveniado: ',
                    value: '${healthPlanModel.profile?.name}',
                  ),
                ],
              ))
            ],
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.clientProfileAddEdit,
                      arguments: healthPlanModel.profile?.id);
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(
      text,
      'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
