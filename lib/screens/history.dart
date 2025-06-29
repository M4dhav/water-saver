import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/providers/history_controller_provider.dart';
import 'package:water_saver/widgets/history_page/date_selector.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyController = ref.watch(historyPageControllerProvider.notifier);
    final data = ref.watch(historyPageControllerProvider);
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
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      width: double.infinity,
                      child: BuildDateSelector(),
                    ),
                    Expanded(
                      child: data.historyData.isEmpty
                          ? const Center(child: Text("No history available"))
                          : ListView(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              children: buildHistoryCards(
                                ref,
                              ),
                            ),
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
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildHistoryCards(
    WidgetRef ref,
  ) {
    final data = ref.watch(historyPageControllerProvider);

    return data.historyData.entries.map((entry) {
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp)),
                        ],
                      ),
                      Text("${historyEntry['quantity']} L",
                          style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      );
    }).toList();
  }
}
