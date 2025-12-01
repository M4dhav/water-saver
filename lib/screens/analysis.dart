import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:water_saver/models/app_themes.dart';
import 'package:water_saver/models/graph_page_model.dart';
import 'package:water_saver/providers/graph_controller_provider.dart';
import 'package:water_saver/widgets/analysis/motor_graph.dart';
import 'package:water_saver/widgets/analysis/threshold_history_graph.dart';
import 'package:water_saver/widgets/analysis/water_consumption_graph.dart';

class AnalysisPage extends ConsumerWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(graphControllerProvider.notifier);
    final pageData = ref.watch(graphControllerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
                fadeInOnStart: false,
                'Analysis',
                textStyle: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
                colors: AppColors.textGradientColors),
          ],
          repeatForever: true,
          isRepeatingAnimation: true,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: pageData.when(
        data: (data) => buildReportBody(controller, data),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildReportBody(GraphController controller, GraphPageModel pageData) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MotorStateGraph(
            controller: controller,
            pageData: pageData,
          ),
          WaterConsumptionGraph(
            controller: controller,
            pageData: pageData,
          ),
          ThresholdHistoryGraph(controller: controller, pageData: pageData),
          SizedBox(height: 3.h),
          _buildRecentActivitySection(),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ...List.generate(3, (index) {
            final activities = [
              {
                'time': '2 hours ago',
                'action': 'Motor turned ON',
                'duration': '45 min'
              },
              {
                'time': '5 hours ago',
                'action': 'Motor turned OFF',
                'duration': '2.5h runtime'
              },
              {
                'time': '8 hours ago',
                'action': 'Motor turned ON',
                'duration': '30 min'
              },
            ];

            return Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      activities[index]['action']!.contains('ON')
                          ? Icons.power_settings_new
                          : Icons.power_off,
                      color: activities[index]['action']!.contains('ON')
                          ? Colors.green
                          : Colors.red,
                      size: 4.w,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activities[index]['action']!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${activities[index]['time']} • ${activities[index]['duration']}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.grey[400],
                    size: 4.w,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
