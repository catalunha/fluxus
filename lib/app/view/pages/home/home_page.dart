import 'package:flutter/material.dart';
import 'package:fluxus/app/core/enums/office_enum.dart';
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
            const HomeSearchTeam(),
            const HomeClientAdd(),
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar paciente'),
                subtitle: const Text('Por ...'),
                onTap: () {
                  Get.toNamed(
                    Routes.clientProfileSearch,
                  );
                },
              ),
            ),
            if (allowedAccess(OfficeEnum.secretaria.id))
              Card(
                child: ListTile(
                  leading: const Icon(Icons.punch_clock),
                  title: const Text('Cadastrar lista de espera'),
                  onTap: () {
                    Get.toNamed(Routes.expectAddEdit);
                  },
                ),
              ),
            if (allowedAccess(OfficeEnum.secretaria.id))
              Card(
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Buscar lista de espera'),
                  subtitle: const Text('Por ...'),
                  onTap: () {
                    Get.toNamed(
                      Routes.expectSearch,
                    );
                  },
                ),
              ),
            const HomeAddAttendance(),
            const HomeSearchAttendance(),
            const HomeAddEvent(),
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
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Buscar Evolução'),
                subtitle: const Text('Por ...'),
                onTap: () {
                  Get.toNamed(Routes.evolutionSearch);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAddEvent extends StatelessWidget {
  const HomeAddEvent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (allowedAccess(OfficeEnum.secretaria.id)) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.event),
          title: const Text('Cadastrar evento'),
          onTap: () {
            Get.toNamed(Routes.eventAddEdit, arguments: null);
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

// class HomeSearchEvent extends StatelessWidget {
//   const HomeSearchEvent({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (allowedAccess(OfficeEnum.secretaria.id)) {
//       return Card(
//         child: ListTile(
//           leading: const Icon(Icons.search),
//           title: const Text('Buscar Evento'),
//           subtitle: const Text('Por ...'),
//           onTap: () {
//             Get.toNamed(Routes.eventSearch);
//           },
//         ),
//       );
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
// }

bool allowedAccess(String officeId) {
  final splashController = Get.find<SplashController>();
  return splashController.officeIdList.contains(officeId);
}

class HomeSearchAttendance extends StatelessWidget {
  const HomeSearchAttendance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (allowedAccess(OfficeEnum.secretaria.id)) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Buscar guia'),
          subtitle: const Text('Por ...'),
          onTap: () {
            Get.toNamed(Routes.attendanceSearch);
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class HomeAddAttendance extends StatelessWidget {
  const HomeAddAttendance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (allowedAccess(OfficeEnum.secretaria.id)) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.view_compact_outlined),
          title: const Text('Gerar guia'),
          onTap: () {
            Get.toNamed(Routes.attendanceAddEdit);
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class HomeClientAdd extends StatelessWidget {
  const HomeClientAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (allowedAccess(OfficeEnum.secretaria.id)) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.person_add),
          title: const Text('Cadastrar paciente'),
          onTap: () {
            Get.toNamed(Routes.clientProfileAddEdit);
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class HomeSearchTeam extends StatelessWidget {
  const HomeSearchTeam({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (allowedAccess(OfficeEnum.secretaria.id)) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Buscar Equipe'),
          subtitle: const Text('Por área'),
          onTap: () {
            Get.toNamed(Routes.teamProfileSearch);
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
