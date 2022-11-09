import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/controllers/profile/client/search/client_search_controller.dart';
import 'package:fluxus/app/view/controllers/splash/splash_controller.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClientProfileCard extends StatelessWidget {
  final _clientSearchController = Get.find<ClientSearchController>();

  final ProfileModel profile;
  ClientProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              profile.photo != null && profile.photo!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        profile.photo!,
                        height: 58,
                        width: 58,
                      ),
                    )
                  : const SizedBox(
                      height: 58,
                      width: 58,
                      child: Icon(Icons.person_outline),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextTitleValue(
                      title: 'Id: ',
                      value: '${profile.id}',
                    ),
                    AppTextTitleValue(
                      title: 'Nome: ',
                      value: '${profile.name}',
                    ),
                    AppTextTitleValue(
                      title: 'DataNasc: ',
                      value: profile.birthday != null
                          ? formatter.format(profile.birthday!)
                          : "...",
                    ),
                    // AppTextTitleValue(
                    //   title: 'id: ',
                    //   value: '${profile.id}',
                    // ),
                    Wrap(
                      children: [
                        // IconButton(
                        //   onPressed: () => copy(profile.id!),
                        //   icon: const Icon(Icons.copy),
                        // ),
                        if (allowedAccess('GExnWAZ5fG'))
                          IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.clientProfileAddEdit,
                                  arguments: profile.id);
                            },
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                        if (allowedAccess('GExnWAZ5fG'))
                          IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.clientProfileView, arguments: {
                                'clientId': profile.id,
                                'includeColumns':
                                    _clientSearchController.includeColumns
                              });
                            },
                            icon: const Icon(
                              Icons.assignment_ind_outlined,
                            ),
                          ),
                        if (allowedAccess('GExnWAZ5fG'))
                          IconButton(
                            onPressed: () => copy(profile.id!),
                            icon: const Icon(
                              Icons.copy,
                            ),
                          ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.evolutionHistory,
                                arguments: profile.id);
                            // _evolutionSearchController
                            //     .listHistoryThisPatient(evolution.patient!.id!);
                          },
                          icon: const Icon(
                            Icons.history,
                          ),
                        ),
                      ],
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

  bool allowedAccess(String officeId) {
    final splashController = Get.find<SplashController>();
    return splashController.officeIdList.contains(officeId);
  }

  copy(String text) async {
    Get.snackbar(
      text, 'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 1),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
