import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/screens/adjustment.dart';
import 'package:water_saver/screens/home.dart';
import 'package:water_saver/screens/settings.dart';
import 'package:water_saver/screens/report.dart';
import 'package:water_saver/theme/gradient.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ReportPage(),
    const AdjustmentsPage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color.fromARGB(0, 111, 111, 111),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedItemColor: const Color(0xFFA0AEC0),
              elevation: 0,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart), label: 'Analytics'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.handyman), label: 'Adjustments'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
