import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppCalendarButton extends StatelessWidget {
  final dateFormat = DateFormat('dd/MM/y');
  final String title;
  final DateTime? Function() getDate;
  final Function(DateTime?) setDate;
  final isBirthDay;
  AppCalendarButton({
    Key? key,
    required this.title,
    required this.getDate,
    required this.setDate,
    this.isBirthDay = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var initialDate = getDate() ?? DateTime.now();
        final DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(DateTime.now().year - 120),
          lastDate: DateTime(DateTime.now().year + 1),
        );
        if (selectedDate != null) {
          setDate(DateTime(
              selectedDate.year, selectedDate.month, selectedDate.day));
        } else {
          setDate(null);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.today,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Obx(
                  () {
                    if (getDate() != null) {
                      return Text('$title  ${dateFormat.format(getDate()!)}');
                    } else {
                      return Text('$title Selecione uma data');
                    }
                  },
                ),
              ],
            ),
            Obx(
              () {
                if (getDate() != null) {
                  DateDuration duration;
                  if (isBirthDay) {
                    duration =
                        AgeCalculator.age(getDate()!, today: DateTime.now());
                  } else {
                    duration =
                        AgeCalculator.age(today: getDate()!, DateTime.now());
                  }
                  if (duration.years < 0) {
                    return const Text(
                      'Oops. Algo errado.',
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return Text(
                        '${duration.years} a, ${duration.months} m, ${duration.days} d');
                  }
                } else {
                  return const Text('...');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
