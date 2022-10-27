import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/profile_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeamProfileCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final ProfileModel profile;
  const TeamProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                child: Column(
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
                    Text(
                      '${profile.id}',
                      style: const TextStyle(fontSize: 8),
                    ),
                  ],
                ),
                onTap: () => copy(profile.id!),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextTitleValue(
                      title: 'Nome: ',
                      value: '${profile.name}',
                    ),
                    Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.clientProfileView,
                                arguments: profile.id);
                          },
                          icon: const Icon(
                            Icons.assignment_ind_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () => copy(profile.id!),
                          icon: const Icon(
                            Icons.copy,
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

  copy(String text) async {
    Get.snackbar(text, 'Id copiado.',
        // backgroundColor: Colors.yellow,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1));
    await Clipboard.setData(ClipboardData(text: text));
  }
}
