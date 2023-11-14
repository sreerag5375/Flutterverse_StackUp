import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/widgets/spacing.dart';

// ignore: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  final userNameController = TextEditingController();
  final passWordController = TextEditingController();
  final confirmController = TextEditingController();
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();

  CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => SystemNavigator.pop(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 28,
                        color: AppColors.SECONDARY_COLOR,
                      )),
                  const Spacing(height: 24),
                  Text(
                    'CREATE ACCOUNT',
                    style: mainHeadingStyle,
                  ),
                  const Spacing(height: 50),
                  const Text(
                    'Username',
                    style: textStyle,
                  ),
                  const Spacing(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: userNameController,
                    cursorColor: AppColors.ASCENT_COLOR,
                    style: TextStyle(color: AppColors.SECONDARY_HEADING),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.4)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.ASCENT_COLOR, width: 1.4),
                      ),
                    ),
                    //
                    //
                    //
                    validator: (value) {
                      // String? errorMessage;
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      } else if (value.length < 3) {
                        return 'Username must have at least 3 characters';
                      } else if (!RegExp(r'^[a-zA-Z_.]*$').hasMatch(value)) {
                        return 'Invalid username. It can only contain letters, dots, and underscores';
                      }
            
                      // if (errorMessage != null) {
                      //   WidgetsBinding.instance.addPostFrameCallback(
                      //     (_) => ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         content: Text(errorMessage!),
                      //       ),
                      //     ),
                      //   );
                      // }
                      return null;
                    },
                  ),
                  const Spacing(height: 20),
                  const Text(
                    'Password',
                    style: textStyle,
                  ),
                  const Spacing(height: 10),
                  TextFormField(
                    controller: passWordController,
                    obscureText: true,
                    cursorColor: AppColors.ASCENT_COLOR,
                    style: TextStyle(color: AppColors.SECONDARY_HEADING),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.4)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.ASCENT_COLOR, width: 1.4),
                      ),
                    ),
                    validator: (value) {
                      // String? errorMessage;
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value.length < 3) {
                        return 'Password must have at least 3 characters';
                      }
                      // if (errorMessage != null) {
                      //   WidgetsBinding.instance.addPostFrameCallback(
                      //     (_) => ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         content: Text(errorMessage!),
                      //       ),
                      //     ),
                      //   );
                      // }
                      return null;
                    },
                  ),
                  const Spacing(height: 20),
                  const Text(
                    'Confirm Password',
                    style: textStyle,
                  ),
                  const Spacing(height: 10),
                  TextFormField(
                    controller: confirmController,
                    obscureText: true,
                    cursorColor: AppColors.ASCENT_COLOR,
                    style: TextStyle(color: AppColors.SECONDARY_HEADING),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.4)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.ASCENT_COLOR, width: 1.4),
                      ),
                    ),
                    validator: (value) {
                      // String? errorMessage;
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      } else if (value != passWordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const Spacing(height: 140),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.ASCENT_COLOR),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setValuess(
                                context: context,
                                uName: userNameController.text,
                                pWord: passWordController.text,
                                conPass: confirmController.text);
            
                            Navigator.pop(context);
                          } else {
                            return;
                          }
                        },
                        child: const Text(
                          'CREATE ACCOUNT',
                          style: textStyle,
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> setValuess(
      {required BuildContext context,
      required String uName,
      required String pWord,
      required String conPass}) async {
    await saveString(stringKey: "username", value: uName);
    await saveString(stringKey: "password", value: pWord);
    await saveString(stringKey: "confirmPass", value: conPass);
    await saveString(stringKey: "loginStatus", value: "accCreated");

    print("saved");
  }
}

Future<bool> saveString(
    {required String value, required String stringKey}) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  return await sharedPref.setString(stringKey, value);
}

Future<String> getString({required String stringKey}) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final val = sharedPref.getString(stringKey);
  if (val != null) {
    return val;
  } else {
    return "noValue";
  }
}

Future<String> getNode() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final val = sharedPref.getString("subcollectionNode");
  if (val != null) {
    return val;
  } else {
    return "noValue";
  }
}

Future<String> checkLoginPref({required String stringKey}) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  final value = sharedPref.getString(stringKey);
  if (value != null) {
    return value;
  } else {
    return "noalue";
  }
}
