import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluxus/app/core/models/event_model.dart';
import 'package:fluxus/app/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  // final _clientProfileController = Get.find<ClientProfileController>();

  final EventModel event;
  const EventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${event.id}',
                    // style: const TextStyle(fontSize: 8),
                  ),
                  Wrap(
                    children: [
                      // IconButton(
                      //   onPressed: () => copy(event.id!),
                      //   icon: const Icon(Icons.copy),
                      // ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.eventAddEdit, arguments: event.id);
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Get.toNamed(Routes.clientProfileView,
                          //     arguments: event.id);
                        },
                        icon: const Icon(
                          Icons.assignment_ind_outlined,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.evolutionList,
                              arguments: event.id);
                        },
                        icon: const Icon(
                          Icons.people,
                        ),
                      ),
                    ],
                  ),
                ],
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
    );
    await Clipboard.setData(ClipboardData(text: text));
  }
}
