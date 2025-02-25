import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controller/history_page_controller.dart';
import 'package:water_saver/modals/date_selector.dart';

class HistoryPage extends StatelessWidget {
  final HistoryPageController historyController =
      Get.put(HistoryPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.opacity, color: Colors.blue),
          onPressed: () {},
        ),
        title: Text(
          'History',
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildDateSelector(),
            Expanded(
              child: Obx(() {
                return historyController.historyData.isEmpty
                    ? Center(child: Text("No history available"))
                    : ListView(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        children: buildHistoryCards(),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateSelector() {
    List<String> dates = historyController.historyData.keys.toList();

    return Container(
      height: 12.h,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          String date = dates[index];
          double litersRefilled =
              historyController.totalLitersPerDate[date] ?? 0.0;

          return Obx(() {
            bool isSelected = historyController.selectedDate.value == date;
            return GestureDetector(
              onTap: () => historyController.updateSelectedDate(date),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      [
                        "Mon",
                        "Tue",
                        "Wed",
                        "Thu",
                        "Fri",
                        "Sat",
                        "Sun"
                      ][index % 7],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 0.5.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(50, 50),
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
                              color: isSelected ? Colors.white : Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  List<Widget> buildHistoryCards() {
    List<Widget> historyCards = [];
    historyController.historyData.forEach((date, entries) {
      if (entries.isNotEmpty) {
        historyCards.add(Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 1.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                Divider(),
                ...entries.map((entry) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry['time'] ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp)),
                          Text("${entry['quantity']} L",
                              style: TextStyle(fontSize: 14.sp)),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
      }
    });
    return historyCards;
  }
}
