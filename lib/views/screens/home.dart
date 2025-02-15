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
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        setState(() {
          _wavePhase += 0.1; // Moves the wave animation
        });
      });

    _waveController.repeat(); // Keeps the waves moving
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
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.opacity,
            color: Colors.blue,
          ),
          onPressed: () {
            // Handle the menu button press
          },
        ),
        title: Text(
          'Home',
        ),
        centerTitle: true,
      ), // Matches reference background
      body: Center(
        child: Container(
          color: Colors.white,
          height: 60.h,
          width: 90.w,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Arc (Background & Progress)
                    CustomPaint(
                      size: Size(80.w, 80.w),
                      painter: WaterLevelArcPainter(
                        progress:
                            _waterLevel / _maxCapacity, // Dynamic progress
                        color: Colors.blue,
                      ),
                    ),
                    // Water Drop with Wavy Effect
                    Container(
                      width: 40.w,
                      height: 50.w,
                      child: CustomPaint(
                        painter: WaterDropPainter(
                          progress:
                              _waterLevel / _maxCapacity, // Dynamic progress
                          fillColor: Colors.blue,
                          wavePhase: _wavePhase, // Controls wave motion
                        ),
                      ),
                    ),
                  ],
                ),
                // Water level text
                Column(
                  children: [
                    Text('100%', style: TextStyle(fontSize: 25.sp)),
                  ],
                ),
                // Refill Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: _refillWater,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 1.5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(1.h),
                          child: Text(
                            'Refill',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.autorenew, color: Colors.blue, size: 7.w)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
