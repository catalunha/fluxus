import 'package:flutter/material.dart';
import 'package:fluxus/app/core/models/attendance_model.dart';
import 'package:fluxus/app/view/pages/attendance/search/part/attendance_card.dart';
import 'package:get/get.dart';

class AttendanceList extends StatelessWidget {
  final List<AttendanceModel> attendanceList;
  const AttendanceList({
    super.key,
    required this.attendanceList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          final person = attendanceList[index];
          return AttendanceCard(
            attendance: person,
          );
        },
      ),
    );
  }
  //   @override
  // Widget build(BuildContext context) {
  //   return Obx(
  //     () => LazyLoadScrollView(
  //       onEndOfPage: () => nextPage(),
  //       scrollOffset: 2,
  //       isLoading: lastPage,
  //       child: ListView.builder(
  //         itemCount: attendanceList.length,
  //         itemBuilder: (context, index) {
  //           final person = attendanceList[index];
  //           return AttendanceCard(
  //             profile: person,
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
}
