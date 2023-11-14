import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/widgets/spacing.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool swValue = false;
  String switchValue = "off";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.ASCENT_COLOR,
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Spacing(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.share,
                        size: 30,
                        color: AppColors.SECONDARY_HEADING,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Share UpTodo App",
                        style: TextStyle(
                            fontSize: 17, color: AppColors.SECONDARY_COLOR),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.SECONDARY_HEADING,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        size: 30,
                        color: AppColors.SECONDARY_HEADING,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Change Language",
                        style: TextStyle(
                            fontSize: 17, color: AppColors.SECONDARY_COLOR),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.SECONDARY_HEADING,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat,
                        size: 30,
                        color: AppColors.SECONDARY_HEADING,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "WhatsApp Chat Support",
                        style: TextStyle(
                            fontSize: 17, color: AppColors.SECONDARY_COLOR),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: swValue,
                  onChanged: toogleSwitch,
                  activeColor: AppColors.ASCENT_COLOR,
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 30,
                        color: AppColors.SECONDARY_HEADING,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 17, color: AppColors.SECONDARY_COLOR),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_rate,
                        size: 30,
                        color: AppColors.SECONDARY_HEADING,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Rate Us",
                        style: TextStyle(
                            fontSize: 17, color: AppColors.SECONDARY_COLOR),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_sweep_outlined,
                        size: 30,
                        color: AppColors.SECONDARY_HEADING,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Clear Data",
                        style: TextStyle(
                            fontSize: 17, color: AppColors.SECONDARY_COLOR),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 30,
                        color: AppColors.SECONDARY_HEADING,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Sign Out",
                        style: TextStyle(
                            fontSize: 17, color: AppColors.SECONDARY_COLOR),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  void toogleSwitch(bool isSelected) {
    print("$swValue");
    setState(() {
      swValue = !swValue;
    });

    if (swValue == false) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Switch is off")));
    } else {
      showAlertDialog(context);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text("Switch is on")));
    }
  }
}

void showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Enter your number"),
    content: TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
