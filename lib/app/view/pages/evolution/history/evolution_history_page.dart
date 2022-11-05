import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/evolution/search/evolution_search_controller.dart';
import 'package:fluxus/app/view/pages/evolution/history/part/evolution_history_list.dart';
import 'package:get/get.dart';

class EvolutionHistoryPage extends StatelessWidget {
  final _evolutionSearchController = Get.find<EvolutionSearchController>();

  EvolutionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evolução deste paciente')),
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: EvolutionHistoryList(
          eventList: _evolutionSearchController.evolutionHistory,
        ),
      ),
    );
  }
}
