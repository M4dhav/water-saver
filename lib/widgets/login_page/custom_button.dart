import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h, // Use responsive height
        width: width.w, // Use responsive width
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(
              borderRadius.w), // Use responsive border radius
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20.sp), // Use responsive icon size
            SizedBox(width: 2.w), // Use responsive spacing
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp, // Use responsive font size
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
