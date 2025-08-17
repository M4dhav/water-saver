import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:water_saver/controllers/auth_controller.dart';
import 'package:water_saver/providers/app_user_controller_provider.dart';
import 'package:water_saver/providers/graph_controller_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF071526),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1C2E),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _buildProfileOption(
                      icon: Icons.person_outline,
                      title: 'Personal Info',
                      onTap: () => context.push('/personalInfo'),
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.notifications_outlined,
                      title: 'Reminders',
                      onTap: () {},
                    ),
                    _buildDivider(),
                    _buildProfileOption(
                      icon: Icons.wifi,
                      title: 'Set Wi-Fi Network',
                      onTap: () => context.push('/wifiConfig'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1C2E),
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
                  color: const Color(0xFF0F1C2E),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
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
                  color: const Color(0xFF0F1C2E),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: _buildProfileOption(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    final router = GoRouter.of(context);
                    final messenger = ScaffoldMessenger.of(context);
                    AuthController().signOut().then((value) {
                      if (value) {
                        ref.invalidate(appUserControllerProvider);
                        ref.invalidate(graphControllerProvider);
                        router.go('/login');
                      } else {
                        messenger.showSnackBar(
                          const SnackBar(content: Text('Logout failed')),
                        );
                      }
                    });
                  },
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
              color: isLogout ? Colors.red : Colors.white70,
              size: 6.w,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: isLogout ? Colors.red : Colors.white,
                ),
              ),
            ),
            if (!isLogout)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
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
      color: Colors.white24,
      indent: 4.w,
      endIndent: 4.w,
    );
  }
}
