import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';

class AuthTextFields extends StatelessWidget {
  const AuthTextFields({
    super.key,
    required this.controller,
    required this.isPassword,
  });

  final TextEditingController controller;
  final bool isPassword;

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      cursorColor: AppColors.ASCENT_COLOR,
      style: TextStyle(color: AppColors.SECONDARY_HEADING),
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.4)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.ASCENT_COLOR, width: 1.4),
        ),
      ),
    );
  }
}
