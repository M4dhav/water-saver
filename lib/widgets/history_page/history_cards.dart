import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controller/history_page_controller.dart';
import 'package:water_saver/views/screens/history.dart';

final HistoryPageController historyController =
    Get.put(HistoryPageController());

List<Widget> buildHistoryCards() {
  return historyController.historyData.entries.map((entry) {
    String date = entry.key;
    List<Map<String, dynamic>> historyEntries = entry.value;

    return Card(
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
            Text(
              date,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...historyEntries.map((historyEntry) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 0.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.blue),
                        SizedBox(width: 2.w),
                        Text(historyEntry['time'] ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${historyEntry['quantity']} L",
                            style: TextStyle(fontSize: 14.sp)),
                        SizedBox(width: 2.w),
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Colors.black),
                          color: Colors.white,
                          onSelected: (String value) {
                            if (value == 'delete') {
                              // Show undo snackbar
                              if (historyEntry['id'] != null) {
                                int entryId = historyEntry['id'] as int;
                                 HistoryPage().showUndoSnackbar(
                                    Get.context!, date, entryId);
                              }
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete History'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }).toList();
}
