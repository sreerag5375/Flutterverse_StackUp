import 'package:flutter/material.dart';

goToLoginPage({required BuildContext context}) {
  Navigator.pushNamed(context, '/loginScreen');
}

goToCreateAccountPage(BuildContext context) {
  Navigator.pushNamed(context, '/createAccountScreen');
}

// username validator
String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }
  if (value.length < 3) {
    return 'Username must have at least 3 characters';
  }
  if (!RegExp(r'^[a-zA-Z_.]*$').hasMatch(value)) {
    return 'Invalid username. It can only contain letters, dots, and underscores';
  }
  return null;
}

String? passwordValidator(String? value) {
  // Add your password validation logic here
  if (value == null || value.isEmpty) {
    return 'Please enter  a password';
  }
  if (value.length < 3) {
    return 'password must have at least 3 characters';
  }
}

// snackbar
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
