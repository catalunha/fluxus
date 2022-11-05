import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/view/controllers/evolution/search/evolution_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';

class EvolutionHistoryCard extends StatelessWidget {
  final _evolutionSearchController = Get.find<EvolutionSearchController>();

  final EvolutionModel evolution;
  EvolutionHistoryCard({Key? key, required this.evolution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  evolution.professional?.photo != null &&
                          evolution.professional!.photo!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            evolution.professional!.photo!,
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
                    '${evolution.professional?.id}',
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
                      title: 'EvolutionId: ',
                      value: '${evolution.id}',
                    ),
                    // AppTextTitleValue(
                    //   title: 'Paciente: ',
                    //   value: '${evolution.patient?.name}',
                    // ),
                    AppTextTitleValue(
                      title: 'Atendido em: ',
                      value: '${evolution.dtAttendance}',
                    ),
                    AppTextTitleValue(
                      title: 'Descrição: ',
                      value: '${evolution.description}',
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
