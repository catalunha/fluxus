import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:fluxus/app/view/controllers/profile/team/search/team_search_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_icon.dart';

class TeamSearchPage extends StatefulWidget {
  final _teamSearchController = Get.find<TeamSearchController>();
  TeamSearchPage({Key? key}) : super(key: key);

  @override
  State<TeamSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<TeamSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione a área de atuação'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Obx(() => Column(
                  children:
                      widget._teamSearchController.officeOptions.entries.map(
                    (e) {
                      return Row(
                        children: [
                          Checkbox(
                            value: e.value.status,
                            onChanged: (value) {
                              setState(() {
                                e.value.status = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(e.value.name),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                )),
            // const SizedBox(height: 100)
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Executar busca',
        child: const Icon(AppIconData.search),
        onPressed: () async {
          widget._teamSearchController
              .search(widget._teamSearchController.officeOptions);
        },
      ),
    );
  }
}
