import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GraphLegendWidget extends StatelessWidget {
  const GraphLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                Icons.circle,
                color: Colors.white,
                size: 16,
              ),
              title: Text("Pump On and off normally"),
            ),
            ListTile(
              leading: Icon(
                Icons.circle,
                color: Colors.red,
                size: 16,
              ),
              title: Text("Power failure during Pump: ON"),
            ),
            ListTile(
              leading: Icon(
                Icons.circle,
                color: Colors.yellow,
                size: 16,
              ),
              title: Text("At present the Pump is ON"),
            ),
          ],
        ),
      ),
    );
  }
}
