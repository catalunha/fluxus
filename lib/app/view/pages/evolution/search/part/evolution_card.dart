import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/evolution_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:get/get.dart';

class EvolutionCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final EvolutionModel evolution;
  const EvolutionCard({Key? key, required this.evolution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${evolution.id}',
                  ),
                  Text(
                    '${evolution.patient?.name}',
                  ),
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
                        style: const TextStyle(fontSize: 8),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.evolutionAddEdit,
                              arguments: evolution.id);
                        },
                        icon: const Icon(
                          Icons.edit,
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
}
