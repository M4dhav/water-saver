import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/widgets/history_page/date_widget.dart';

Widget buildDateSelector() {
  return SingleChildScrollView(
    // Prevent overflow by making it scrollable
    child: Column(
      mainAxisSize: MainAxisSize.min, // Prevent unnecessary height issues
      children: [
        // Month & Year Selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 18),
              onPressed: historyController.previousMonth,
            ),
            Obx(() {
              return Text(
                historyController.getCurrentMonthYear(),
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              );
            }),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 18),
              onPressed: historyController.nextMonth,
            ),
          ],
        ),

        SizedBox(height: 1.h),

        // Week Days Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
              .map((day) => Text(day, style: TextStyle(fontSize: 15.sp)))
              .toList(),
        ),

        SizedBox(height: 1.h),

        // Dates (Week View / Full Month Dropdown)
        Obx(() {
          List<String> dates = historyController.getCurrentMonthDates();
          List<String> currentWeekDates =
              historyController.getCurrentWeekDates(dates);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: historyController.isDropdownExpanded.value ? 35.h : 5.h,
            child: Column(
              children: [
                if (!historyController.isDropdownExpanded.value)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        currentWeekDates.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: dateCircleWidget(currentWeekDates[index]),
                        ),
                      ),
                    ),
                  ),
                if (historyController.isDropdownExpanded.value)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.h),
                      child: SizedBox(
                        height: 30.h, // Set fixed height to prevent overflow
                        child: GridView.builder(
                          shrinkWrap: true, // Prevent infinite height issues
                          physics:
                              const NeverScrollableScrollPhysics(), // Prevent double scrolling
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
                              child: dateCircleWidget(dates[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),

        // Expand/Collapse Button
        Obx(() {
          return IconButton(
            icon: Icon(historyController.isDropdownExpanded.value
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
            onPressed: historyController.toggleDropdown,
          );
        }),
      ],
    ),
  );
}
