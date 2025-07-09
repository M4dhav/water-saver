import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/auth_controller.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/providers/graph_controller_provider.dart';
import 'package:water_saver/providers/history_controller_provider.dart';
import 'package:water_saver/screens/personal_info_screen.dart';


class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.person_outline,
                      title: 'Personal Info',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PersonalInfoScreen(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.notifications_outlined,
                      title: 'Reminders',
                      onTap: () {},
                    ),
                    _buildDivider(),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.security_outlined,
                      title: 'Account & Security',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.link_outlined,
                      title: 'Linked Accounts',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.palette_outlined,
                      title: 'App Appearance',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.analytics_outlined,
                      title: 'Data & Analytics',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () => AuthController().signOut().then((value) {
                    if (value) {
                      ref.invalidate(appUserControllerProvider);
                      ref.invalidate(graphControllerProvider);
                      ref.invalidate(historyPageControllerProvider);
                      context.go('/login');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout failed')),
                      );
                    }
                  }),
                  isLogout: true,
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout ? Colors.red : Colors.grey[600],
              size: 6.w,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isLogout ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (!isLogout)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 4.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
      indent: 4.w,
      endIndent: 4.w,
    );
  }
}
