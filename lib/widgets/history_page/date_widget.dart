import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controller/history_page_controller.dart';
import 'package:water_saver/widgets/history_page/date_circles.dart';

final HistoryPageController historyController =
    Get.put(HistoryPageController());

Widget dateCircleWidget(String date) {
  double litersRefilled = historyController.totalLitersPerDate[date] ?? 1700; //fetch value accordaing to date from device

  return Obx(() {
    bool isSelected = historyController.selectedDate.value == date;

    return GestureDetector(
      onTap: () => historyController.updateSelectedDate(date),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(40, 40),
                painter: DateCirclePainter(
                  litersRefilled: litersRefilled,
                  isSelected: isSelected,
                ),
              ),
              Text(
                date.split('-').last,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  });
}
