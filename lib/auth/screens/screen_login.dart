import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/services/functions/login_signup_functions.dart';
import 'package:todo_app/widgets/outlined_btn_full_width.dart';
import 'package:todo_app/widgets/textfield_auth.dart';
import '/auth/screens/screen_create_account.dart';
import '/utils/colors.dart';
import '/utils/const.dart';
import '/utils/styles.dart';
import '/widgets/spacing.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.PADDING_INLINE),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacing(height: 20),
                IconButton(
                    onPressed: () => SystemNavigator.pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                      color: AppColors.SECONDARY_COLOR,
                    )),
                const Spacing(height: 24),
                Text(
                  'LOGIN',
                  style: mainHeadingStyle,
                ),
                const Spacing(height: 50),
                const Text(
                  'Username',
                  style: textStyle,
                ),
                const Spacing(height: 10),
                AuthTextFields(
                  controller: usernameController,
                  isPassword: false,
                  
                ),
                const Spacing(height: 20),
                const Text(
                  'Password',
                  style: textStyle,
                ),
                const Spacing(height: 10),

                AuthTextFields(
                    controller: passwordController,
                    isPassword: true,
                    ),
                const Spacing(height: 180),
                // button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.ASCENT_COLOR),
                      onPressed: () {
                        checkFields(context, usernameController.text,
                            passwordController.text);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'LOGIN',
                          style: textStyle,
                        ),
                      )),
                ),
                const Spacing(height: 28),
                FullWidthOutlinedButton(onPress: () {
                  Navigator.pushNamed(context, '/createAccountScreen');
                }),
                // create account
                // TextButton(
                //     onPressed: () {
                //       Navigator.pushNamed(context, '/createAccountScreen');
                //     },
                //     child: const Text('create account'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkFields(
      BuildContext context, String username, String password) async {
    String usernameShared = await getString(stringKey: "username");
    String passwordShared = await getString(stringKey: "password");
    print("Log details $username ---    $password");
    if (usernameShared == username && passwordShared == password) {
      // ignore: use_build_context_synchronously
      loggedin();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    } else {
      const msg = " please check username and password";
      // ignore: use_build_context_synchronously
      showSnackBar(context, msg);
    }
  }
}

Future<void> loggedin() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await saveString(stringKey: "loginStatus", value: "loggedin");
}
