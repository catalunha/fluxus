import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/evolution/search/evolution_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';

class EvolutionCard extends StatelessWidget {
  final _evolutionSearchController = Get.find<EvolutionSearchController>();

  final EvolutionModel evolution;
  EvolutionCard({Key? key, required this.evolution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  evolution.patient?.photo != null &&
                          evolution.patient!.photo!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            evolution.patient!.photo!,
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
                    '${evolution.patient?.id}',
                    // style: const TextStyle(fontSize: 8),
                  ),
                ],
              ),
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextTitleValue(
                      title: 'Id: ',
                      value: '${evolution.id}',
                    ),
                    AppTextTitleValue(
                      title: 'Nome: ',
                      value: '${evolution.patient?.name}',
                    ),
                    AppTextTitleValue(
                      title: 'Atendido em: ',
                      value: '${evolution.dtAttendance}',
                    ),
                    Wrap(
                      children: [
                        IconButton(
                          onPressed: () async {
                            await Get.toNamed(Routes.evolutionAddEdit,
                                arguments: evolution.id);
                            Get.back();
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.evolutionHistory,
                                arguments: evolution.patient!.id);
                            // _evolutionSearchController
                            //     .listHistoryThisPatient(evolution.patient!.id!);
                          },
                          icon: const Icon(Icons.history),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
