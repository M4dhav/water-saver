// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:water_saver/providers/adjustment_controller_provider.dart';
// import 'package:water_saver/widgets/adjustments_page/toggle_widget.dart';

// class AutoDataLogWidget extends ConsumerWidget {
//   const AutoDataLogWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.watch(adjustmentControllerProvider.notifier);
//     final adjustmentsData = ref.watch(adjustmentControllerProvider);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.all(3.w),
//             margin: EdgeInsets.only(right: 2.w),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Auto Data Log",
//                     style: TextStyle(
//                         fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                 Row(
//                   children: [
//                     ToggleButtonWidget(
//                         text: "Off",
//                         isSelected: !adjustmentsData.autoDataLog,
//                         onTap: () {
//                           controller.toggleAutoDataLog(false);
//                         }),
//                     ToggleButtonWidget(
//                         text: "On",
//                         isSelected: adjustmentsData.autoDataLog,
//                         onTap: () {
//                           controller.toggleAutoDataLog(true);
//                         }),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             controller.updateSettings();
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue,
//             minimumSize: Size(20.w, 4.h),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           ),
//           child: Text(
//             "Update",
//             style: TextStyle(fontSize: 16.sp, color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }
