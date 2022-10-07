import 'package:flutter/material.dart';
import 'package:fluxus/app/view/controllers/profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppCalendarButton extends StatelessWidget {
  final ProfileController _controller = Get.find();
  final dateFormat = DateFormat('dd/MM/y');

  AppCalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var initialDate = _controller.selectedDate ?? DateTime.now();
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(DateTime.now().year),
          lastDate: DateTime(DateTime.now().year + 1),
        );
        _controller.selectedDate = selectedDate;
      },
      // borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Obx(
              () {
                if (_controller.selectedDate != null) {
                  return Text(
                      'Nascimento:  ${dateFormat.format(_controller.selectedDate!)}');
                } else {
                  return const Text('Nascimento: Selecione uma data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
