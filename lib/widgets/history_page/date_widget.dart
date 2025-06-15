import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/history_controller_provider.dart';
import 'package:water_saver/widgets/history_page/date_circles.dart';

class DateCircleWidget extends ConsumerWidget {
  final String date;
  const DateCircleWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyController = ref.watch(historyPageControllerProvider.notifier);
    final data = ref.watch(historyPageControllerProvider);
    double litersRefilled = data.totalLitersPerDate[date] ??
        1700; //fetch value accordaing to date from device

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
                  isSelected: data.selectedDate == date,
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
  }
}
