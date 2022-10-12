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
      body: Column(
        children: [
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
                  const Text('Por nome, CPF, Telefone, Data de Nascimento'),
              onTap: () {
                Get.toNamed(Routes.clientProfileSearch);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Buscar paciente'),
              subtitle: const Text('Por número do convênio'),
              onTap: () {
                Get.toNamed(Routes.clientProfileSearch);
              },
            ),
          ),
        ],
      ),
    );
  }
}
