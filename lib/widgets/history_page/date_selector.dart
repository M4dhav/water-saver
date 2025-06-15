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
    return SingleChildScrollView(
      child: Column(
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
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                .map((day) => Text(day, style: TextStyle(fontSize: 15.sp)))
                .toList(),
          ),
          SizedBox(height: 1.h),
          Builder(
            builder: (context) {
              List<String> dates = data.getCurrentMonthDates();
              List<String> currentWeekDates =
                  historyController.getCurrentWeekDates(dates);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: data.isDropdownExpanded ? 35.h : 5.h,
                child: Column(
                  children: [
                    if (!data.isDropdownExpanded)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            currentWeekDates.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: DateCircleWidget(
                                  date: currentWeekDates[index]),
                            ),
                          ),
                        ),
                      ),
                    if (data.isDropdownExpanded)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: SizedBox(
                          height: 30.h,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              crossAxisSpacing: 1.4.w,
                              mainAxisSpacing: 1.h,
                            ),
                            itemCount: dates.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(1.w),
                                child: DateCircleWidget(date: dates[index]),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: Icon(data.isDropdownExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down),
              onPressed: historyController.toggleDropdown,
            );
          }),
        ],
      ),
    );
  }
}
