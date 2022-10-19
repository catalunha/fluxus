import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/team/search/team_search_controller.dart';
import 'package:get/get.dart';

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
        title: const Text('Buscando time'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: const Text('Avaliadoras'),
                    onTap: () =>
                        widget._teamSearchController.search('wntNbb1000'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: const Text('Profissionais'),
                    onTap: () =>
                        widget._teamSearchController.search('4Zr3rIyGUd'),
                  ),
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
