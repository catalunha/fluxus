import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/evolution/history/evolution_history_controller.dart';
import 'package:fluxus/app/view/pages/evolution/history/part/evolution_history_list.dart';
import 'package:get/get.dart';

class EvolutionHistoryPage extends StatelessWidget {
  final _evolutionHistoryController = Get.find<EvolutionHistoryController>();

  EvolutionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    log('${_evolutionHistoryController.evolutionHistory}',
        name: 'EvolutionHistoryPage.build');
    return Scaffold(
      appBar: AppBar(title: const Text('Evolução deste paciente')),
      body: Column(
        children: [
          InkWell(
            onTap: _evolutionHistoryController.lastPage
                ? null
                : () {
                    _evolutionHistoryController.nextPage();
                  },
            child: Obx(() => Container(
                  color: _evolutionHistoryController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _evolutionHistoryController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: EvolutionHistoryList(
                eventList: _evolutionHistoryController.evolutionHistory,
              ),
            ),
          ),
        ],
      ),
      // body: ConstrainedBox(
      //   constraints: const BoxConstraints(maxWidth: 600),
      //   child: EvolutionHistoryList(
      //     eventList: _evolutionHistoryController.evolutionHistory,
      //   ),
      // ),
    );
  }
}
