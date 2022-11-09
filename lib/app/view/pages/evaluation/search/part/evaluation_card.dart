import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EvaluationCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final EvaluationModel evaluation;
  const EvaluationCard({Key? key, required this.evaluation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final splashController = Get.find<SplashController>();
    String profileId = splashController.userModel!.profile!.id!;
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextTitleValue(
                    title: 'Id: ',
                    value: evaluation.id,
                  ),
                  AppTextTitleValue(
                    title: 'Nome: ',
                    value: evaluation.name,
                  ),
                  AppTextTitleValue(
                    title: 'Publica ? ',
                    value: evaluation.isPublic! ? "Sim" : "Não",
                  ),
                  Wrap(
                    children: [
                      // IconButton(
                      //   onPressed: () => copy(evaluation.id!),
                      //   icon: const Icon(Icons.copy),
                      // ),
                      evaluation.professionalId == profileId
                          ? IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.evaluationAddEdit,
                                    arguments: evaluation.id);
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            )
                          : const SizedBox.shrink(),
                      IconButton(
                        onPressed: () => copy(evaluation.description!),
                        icon: const Icon(Icons.copy),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(
      'Ficha copiada',
      'colar na evolução',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 1),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
