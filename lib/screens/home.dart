import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/drop_controller.dart';
import 'package:water_saver/controllers/home_history%20controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_saver/widgets/home_page/arc.dart';
import 'package:water_saver/widgets/home_page/drop.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late DropController _dropController;
  late HomeHistoryController _historyController;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userDocFuture;

  @override
  void initState() {
    super.initState();
    _dropController = DropController(this, () {
      setState(() {});
    });
    _historyController = HomeHistoryController();
    _dropController.initAnimation();
    _historyController.fetchWaterHistory();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      _userDocFuture =
          FirebaseFirestore.instance.collection('users').doc(userId).get();
    }
  }

  void _refetchUserDoc() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      setState(() {
        _userDocFuture =
            FirebaseFirestore.instance.collection('users').doc(userId).get();
      });
    }
  }

  @override
  void dispose() {
    _dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return const Center(child: Text('No user ID found'));
    }
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: _userDocFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Firestore error: \\${snapshot.error}'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No user data found'));
        }
        final data = snapshot.data!.data()!;
        final bool hasReservoir = data['hasReservoir'] ?? false;
        final int reservoir = data['reservoir'] ?? 0;
        final int tank = data['tank'] ?? 0;
        final int currentTankLevel =
            1200; // TODO: Replace with ESP API value for tank
        final int currentReservoirLevel =
            200; // TODO: Replace with ESP API value for reservoir
        double arcProgress =
            (tank > 0) ? (currentTankLevel / tank).clamp(0.0, 1.0) : 0.0;
        double dropProgress = (reservoir > 0)
            ? (currentReservoirLevel / reservoir).clamp(0.0, 1.0)
            : 0.0;
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
              'Home',
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
          body: Padding(
            padding: EdgeInsets.only(left: 4.5.w, top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 51.h,
                  width: 90.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: Size(30.h, 75.w),
                            painter: WaterLevelArcPainter(
                              progress: arcProgress,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: 36.w,
                            height: 20.h,
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                CustomPaint(
                                  size: Size(36.w, 20.h),
                                  painter: WaterDropPainter(
                                    progress: dropProgress,
                                    fillColor: Colors.blue,
                                    wavePhase: _dropController.wavePhase,
                                  ),
                                ),
                                if ((hasReservoir && reservoir > 0) ||
                                    (!hasReservoir && tank > 0))
                                  Center(
                                    child: Text(
                                      '${(dropProgress * 100).toInt()}%',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4,
                                            color: Colors.black26,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 30.h),
                                child: Text(
                                  '${(arcProgress * 100).toInt()}%',
                                  style: TextStyle(
                                      fontSize: 26.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ),
                              Text(
                                hasReservoir
                                    ? '$currentReservoirLevel L / $reservoir L'
                                    : '$currentTankLevel L / $tank L',
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.only(left: 6.w, bottom: 1.1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId)
                                    .update({'reservoir': tank});
                                _refetchUserDoc();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 9.w, vertical: 1.5.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(0.5.h),
                                child: Text(
                                  'Refill',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(Icons.autorenew,
                                color: Colors.blue, size: 7.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(right: 4.5.w, top: 1.h),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "History",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "View All →",
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Divider(
                          height: 1, thickness: 1, color: Colors.grey.shade300),
                      ListView.separated(
                        itemCount: _historyController.waterHistory.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.shade300,
                        ),
                        itemBuilder: (context, index) {
                          final record = _historyController.waterHistory[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/tank.png',
                                  width: 8.w,
                                  height: 8.w,
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    record["time"]!,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  record["quantity"]!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                const Icon(Icons.more_vert, color: Colors.black)
                              ],
                            ),
                          );
                        },
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Colors.grey.shade300),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
