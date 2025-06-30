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
  bool _isMotorOn = false;
  DateTime? _motorStartTime;

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
      _loadMotorState(userId);
    }
  }

  Future<void> _loadMotorState(String userId) async {
    try {
      const String deviceId = "WFRFTNRV32851105A1000315V1";
      final docSnapshot = await FirebaseFirestore.instance
          .collection('user_data_upload')
          .doc(deviceId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final motorOn = data['MotorOn'] as String?;

        setState(() {
          _isMotorOn = motorOn == 'yes';
        });
        if (_isMotorOn) {
          _motorStartTime = DateTime.now();
        }
      } else {
        setState(() {
          _isMotorOn = false;
        });
      }
    } catch (e) {
      setState(() {
        _isMotorOn = false;
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      final isLandscape = MediaQuery.of(context).orientation ==
                          Orientation.landscape;
                      final double arcHeight = isLandscape ? 70.h : 30.h;
                      final double arcWidth = isLandscape ? 85.w : 75.w;
                      final double dropWidth = isLandscape ? 18.w : 36.w;
                      final double dropHeight = isLandscape ? 50.h : 20.h;
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 90.w,
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomPaint(
                                    size: Size(arcHeight, arcWidth),
                                    painter: WaterLevelArcPainter(
                                      progress: arcProgress,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: dropWidth,
                                    height: dropHeight,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      alignment: Alignment.center,
                                      children: [
                                        CustomPaint(
                                          size: Size(dropWidth, dropHeight),
                                          painter: WaterDropPainter(
                                            progress: dropProgress,
                                            fillColor: Colors.blue,
                                            wavePhase:
                                                _dropController.wavePhase,
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
                                ],
                              ),
                              if (isLandscape) SizedBox(height: 0.05.h),
                              Text(
                                '${(arcProgress * 100).toInt()}%',
                                style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                '$currentTankLevel L / $tank L',
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.grey),
                              ),
                              SizedBox(height: 3.h),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 6.w, bottom: 1.1.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 1.h),
                                      decoration: BoxDecoration(
                                        color: _isMotorOn
                                            ? Colors.blue.withValues(alpha: 0.1)
                                            : Colors.grey
                                                .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: _isMotorOn
                                              ? Colors.blue
                                              : Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Motor: ${_isMotorOn ? 'ON' : 'OFF'}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: _isMotorOn
                                                  ? Colors.blue
                                                  : Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(width: 3.w),
                                          Switch(
                                            value: _isMotorOn,
                                            onChanged: (bool value) async {
                                              setState(() {
                                                _isMotorOn = value;
                                              });
                                              try {
                                                const String deviceId =
                                                    "WFRFTNRV32851105A1000315V1";
                                                if (value) {
                                                  _motorStartTime =
                                                      DateTime.now();
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'user_data_upload')
                                                      .doc(deviceId)
                                                      .update({
                                                    'MotorOn': "yes",
                                                    'MotorOff': "no",
                                                  });
                                                } else {
                                                  int durationInSeconds = 0;
                                                  if (_motorStartTime != null) {
                                                    final duration = DateTime
                                                            .now()
                                                        .difference(
                                                            _motorStartTime!);
                                                    durationInSeconds =
                                                        duration.inSeconds;
                                                  }
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'user_data_upload')
                                                      .doc(deviceId)
                                                      .update({
                                                    'MotorOn': "no",
                                                    'MotorOff': "yes",
                                                    'MotorOnDuration':
                                                        durationInSeconds,
                                                  });
                                                  _motorStartTime = null;
                                                }
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Failed to update motor data: $e'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            },
                                            activeColor: Colors.blue,
                                            activeTrackColor: Colors.blue
                                                .withValues(alpha: 0.3),
                                            inactiveThumbColor: Colors.grey,
                                            inactiveTrackColor: Colors.grey
                                                .withValues(alpha: 0.3),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    // Icon(Icons.power_settings_new,
                                    //     color: _isMotorOn
                                    //         ? Colors.blue
                                    //         : Colors.grey,
                                    //     size: 7.w),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(right: 4.5.w, top: 1.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.shade300),
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
                            final record =
                                _historyController.waterHistory[index];
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
                                  const Icon(Icons.more_vert,
                                      color: Colors.black)
                                ],
                              ),
                            );
                          },
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.shade300),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
