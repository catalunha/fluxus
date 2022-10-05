import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/auth/splash/splash_controller.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('O começo de uma loooonga jornada...')],
      ),
    );
  }
}
