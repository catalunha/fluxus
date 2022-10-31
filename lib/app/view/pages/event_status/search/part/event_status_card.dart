import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/event_status_model.dart';
import 'package:fluxus/app/view/pages/utils/app_text_title_value.dart';
import 'package:get/get.dart';

class EventStatusCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final EventStatusModel eventStatus;
  const EventStatusCard({Key? key, required this.eventStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextTitleValue(
                      title: 'Nome: ',
                      value: '${eventStatus.id}',
                    ),
                    AppTextTitleValue(
                      title: 'Nome: ',
                      value: '${eventStatus.name}',
                    ),
                    IconButton(
                        onPressed: () => copy(eventStatus.id!),
                        icon: const Icon(Icons.copy))
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
    Get.snackbar(
      text,
      'Id copiado.',
      // backgroundColor: Colors.yellow,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 1),
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
