import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;

  const InputField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.h),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: isPassword ? Icon(Icons.visibility_off) : null,
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.grey[200],
            labelStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
