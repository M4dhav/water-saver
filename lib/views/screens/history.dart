import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controller/history_page_controller.dart';
import 'package:water_saver/widgets/history_page/date_selector.dart';
import 'package:water_saver/widgets/history_page/history_cards.dart';

class HistoryPage extends StatelessWidget {
  final HistoryPageController historyController =
      Get.put(HistoryPageController());

  HistoryPage({super.key});

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
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  width: double.infinity,
                  child: buildDateSelector(), // Date selector with dropdown
                ),
                Expanded(
                  child: Obx(() {
                    var historyData = historyController.historyData;
                    return historyData.isEmpty
                        ? const Center(child: Text("No history available"))
                        : ListView(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            children: buildHistoryCards(),
                          );
                  }),
                ),
              ],
            ),
            // Obx(() {
            //   if (historyController.isDropdownExpanded.value) {
            //     return Positioned.fill(
            //       child: GestureDetector(
            //         onTap: historyController
            //             .toggleDropdown, 
            //         child: Container(
            //           color: Colors.black
            //               .withValues(alpha:0.3), 
            //         ),
            //       ),
            //     );
            //   }
            //   return const SizedBox.shrink();
            // }),
          ],
        ),
      ),
    );
  }

  void showUndoSnackbar(BuildContext context, String date, int entryId) {
    final deletedEntry = historyController.historyData[date]
        ?.firstWhere((entry) => entry['id'] == entryId);
    historyController.deleteHistoryEntry(date, entryId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('History deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            if (deletedEntry != null) {
              historyController.addHistoryEntry(date, deletedEntry);
            }
          },
        ),
      ),
    );
  }
}
