import 'package:flutter/material.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/pages/home/parts/popmenu_user.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Olá, ${_splashController.userModel!.profile!.name ?? 'Atualize seu perfil.'}.")),
        actions: [
          PopMenuButtonPhotoUser(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar Equipe'),
                subtitle: const Text('Por área'),
                onTap: () {
                  Get.toNamed(Routes.teamProfileSearch);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person_add),
                title: const Text('Cadastrar paciente'),
                onTap: () {
                  Get.toNamed(Routes.clientProfileAddEdit, arguments: null);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar paciente'),
                subtitle:
                    const Text('Por Nome, CPF, Telefone, Data de Nascimento'),
                onTap: () {
                  Get.toNamed(Routes.clientProfileSearch);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar paciente'),
                subtitle: const Text('Por Número do convênio'),
                onTap: () {
                  Get.toNamed(Routes.healthPlanSearch);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.view_compact_outlined),
                title: const Text('Gerar guia'),
                onTap: () {
                  Get.toNamed(Routes.attendanceAddEdit);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar guia'),
                subtitle: const Text('Por ...'),
                onTap: () {
                  Get.toNamed(Routes.attendanceSearch);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Cadastrar evento'),
                onTap: () {
                  Get.toNamed(Routes.eventAddEdit, arguments: null);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar Evento'),
                subtitle: const Text('Por ...'),
                onTap: () {
                  Get.toNamed(Routes.eventSearch);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.add_comment_outlined),
                title: const Text('Cadastrar Ficha de avaliação'),
                onTap: () {
                  Get.toNamed(Routes.evaluationAddEdit, arguments: null);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar Ficha de avaliação'),
                subtitle: const Text('Por ...'),
                onTap: () {
                  Get.toNamed(Routes.evaluationSearch);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
