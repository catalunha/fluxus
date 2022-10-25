import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/evaluation_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EvaluationCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final EvaluationModel evaluation;
  const EvaluationCard({Key? key, required this.evaluation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${evaluation.id}',
                    style: const TextStyle(fontSize: 8),
                  ),
                  Text(
                    '${evaluation.name}',
                    style: const TextStyle(fontSize: 8),
                  ),
                  Text(
                    'Publica: ${evaluation.isPublic}',
                    style: const TextStyle(fontSize: 8),
                  ),
                  Wrap(
                    children: [
                      // IconButton(
                      //   onPressed: () => copy(evaluation.id!),
                      //   icon: const Icon(Icons.copy),
                      // ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.evaluationAddEdit,
                              arguments: evaluation.id);
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Get.toNamed(Routes.clientProfileView,
                          //     arguments: evaluation.id);
                        },
                        icon: const Icon(
                          Icons.assignment_ind_outlined,
                        ),
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
      text,
      'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
