import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/expect_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/expect/search/expect_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpectCard extends StatelessWidget {
  final _expectSearchController = Get.find<ExpectSearchController>();

  final ExpectModel expect;
  ExpectCard({Key? key, required this.expect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy hh:mm');

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextTitleValue(
                        title: 'Id: ',
                        value: expect.id,
                      ),
                      AppTextTitleValue(
                        title: 'Paciente: ',
                        value: expect.patient!.name,
                      ),
                      AppTextTitleValue(
                        title: 'Conv. code: ',
                        value: expect.healthPlan!.code,
                      ),
                      AppTextTitleValue(
                        title: 'Conv. nome: ',
                        value: expect.healthPlan!.healthPlanType?.name,
                      ),
                      AppTextTitleValue(
                        title: 'Descrição: ',
                        value: expect.description,
                      ),
                      AppTextTitleValue(
                        title: 'Status: ',
                        value: expect.eventStatus?.name,
                      ),
                      AppTextTitleValue(
                        title: 'Especialidade: ',
                        value: expect.expertise?.name,
                      ),
                      AppTextTitleValue(
                        title: 'Archivada ? ',
                        value: expect.isArchived! ? "Sim" : "Não",
                      ),
                      Wrap(
                        // spacing: 100,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.expectAddEdit,
                                  arguments: expect.id);
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () => copy(expect.id!),
                          //   icon: const Icon(Icons.copy),
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     _expectSearchController.archiveExpect(
                          //         expect, true);
                          //     Get.back();
                          //   },
                          //   icon: const Icon(Icons.archive),
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     _expectSearchController.archiveExpect(
                          //         expect, false);
                          //     Get.back();
                          //   },
                          //   icon: const Icon(Icons.unarchive),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(
      text, 'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 1),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
