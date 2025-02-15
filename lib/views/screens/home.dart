import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/modals/arc.dart';
import 'package:water_saver/modals/drop.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  double _waterLevel = 1650;
  final double _maxCapacity = 2500;
  double _wavePhase = 0.0;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Smooth wave transition
    )..addListener(() {
        setState(() {
          _wavePhase += 0.05; // Slower & smoother wave movement
          if (_wavePhase > 2 * 3.1415)
            _wavePhase = 0; // Reset phase to avoid overflow
        });
      });

    _waveController.repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _refillWater() {
    setState(() {
      _waterLevel = _maxCapacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.opacity, color: Colors.blue),
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
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.all(5.w),
          height: 56.h,
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
                      progress: _waterLevel / _maxCapacity,
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 18.h,
                    child: CustomPaint(
                      painter: WaterDropPainter(
                        progress: _waterLevel / _maxCapacity,
                        fillColor: Colors.blue,
                        wavePhase: _wavePhase, // Now properly updating
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Text(
                          '${((_waterLevel / _maxCapacity) * 100).toInt()}%',
                          style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      Text(
                        '${_waterLevel.toInt()} L / 2500 L',
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _refillWater,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 1.5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.h),
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
                  Icon(Icons.autorenew, color: Colors.blue, size: 7.w),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
