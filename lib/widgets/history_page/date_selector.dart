import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/history_controller_provider.dart';
import 'package:water_saver/widgets/history_page/date_widget.dart';

class BuildDateSelector extends ConsumerWidget {
  const BuildDateSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyController = ref.watch(historyPageControllerProvider.notifier);
    final data = ref.watch(historyPageControllerProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 18),
              onPressed: historyController.previousMonth,
            ),
            Text(
              historyController.getCurrentMonthYear(),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 18),
              onPressed: historyController.nextMonth,
            ),
          ],
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: data.isDropdownExpanded
              ? (MediaQuery.of(context).orientation == Orientation.landscape
                  ? MediaQuery.of(context).size.height *
                      0.4 // Use 60% of available height in landscape
                  : 35.h) // Keep original height in portrait
              : null,
          constraints: data.isDropdownExpanded
              ? BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height *
                      0.7, // Never exceed 70% of screen height
                  minHeight: 200, // Minimum height for usability
                )
              : null,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: data.isDropdownExpanded
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          "Mon",
                          "Tue",
                          "Wed",
                          "Thu",
                          "Fri",
                          "Sat",
                          "Sun"
                        ]
                            .map((day) =>
                                Text(day, style: TextStyle(fontSize: 15.sp)))
                            .toList(),
                      ),
                      SizedBox(height: 1.h),
                      Builder(
                        builder: (context) {
                          List<String> dates = data.getCurrentMonthDates();
                          List<String> gridDates;
                          int leading = 0;
                          int trailing = 0;
                          gridDates = dates;
                          if (gridDates.isNotEmpty) {
                            final firstDate = DateTime.parse(gridDates.first);
                            int startWeekday = firstDate.weekday;
                            leading = startWeekday - 1;
                            int total = leading + gridDates.length;
                            trailing = (7 - (total % 7)) % 7;
                          }
                          List<Widget> gridChildren = [];
                          for (int i = 0; i < leading; i++) {
                            gridChildren.add(const SizedBox.shrink());
                          }
                          for (var date in gridDates) {
                            gridChildren.add(DateCircleWidget(date: date));
                          }
                          for (int i = 0; i < trailing; i++) {
                            gridChildren.add(const SizedBox.shrink());
                          }
                          return GridView.count(
                            crossAxisCount: 7,
                            crossAxisSpacing: 1.4.w,
                            mainAxisSpacing: 1.h,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: gridChildren,
                          );
                        },
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        "Mon",
                        "Tue",
                        "Wed",
                        "Thu",
                        "Fri",
                        "Sat",
                        "Sun"
                      ]
                          .map((day) =>
                              Text(day, style: TextStyle(fontSize: 15.sp)))
                          .toList(),
                    ),
                    SizedBox(height: 1.h),
                    Builder(
                      builder: (context) {
                        DateTime selected = DateTime.parse(data.selectedDate);

                        int weekday = selected.weekday;
                        DateTime weekStart =
                            selected.subtract(Duration(days: weekday - 1));

                        List<Widget> gridChildren = [];
                        for (int i = 0; i < 7; i++) {
                          DateTime d = weekStart.add(Duration(days: i));
                          String dateStr = d.toIso8601String().substring(0, 10);
                          gridChildren.add(DateCircleWidget(date: dateStr));
                        }

                        return GridView.count(
                          crossAxisCount: 7,
                          crossAxisSpacing: 1.4.w,
                          mainAxisSpacing: 1.h,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: gridChildren,
                        );
                      },
                    ),
                  ],
                ),
        ),
        Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(data.isDropdownExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: historyController.toggleDropdown,
            );
          },
        ),
      ],
    );
  }
}
