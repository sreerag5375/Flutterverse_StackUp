import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/screens/screen_create_account.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/widgets/spacing.dart';

class AddScreen extends StatelessWidget {
  final CollectionReference task =
      FirebaseFirestore.instance.collection('task');

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // final TextEditingController domainController = TextEditingController();

  Future<void> addTask(BuildContext context) async {
    final data = {
      'description': descriptionController.text,
      'title': titleController.text,
    };

    final usernameId = await getString(stringKey: "username");
    // final dateTime = DateTime.now().microsecondsSinceEpoch;
    print("Add Task Username $usernameId");
    final userID = "$usernameId";
    /* saveString(value: "subcollectionNode", stringKey: usernameId);
    final nodeCollection=await getNode();*/
    DocumentReference userDocument = task.doc(userID);
    CollectionReference userTasks = userDocument.collection("nodeCollection");
    await userTasks.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        appBar: AppBar(
          title: const Text('Add Task'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.ASCENT_COLOR,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacing(height: 22),
              TextFormField(
                controller: titleController,
                cursorColor: AppColors.ASCENT_COLOR,
                style: TextStyle(color: AppColors.SECONDARY_HEADING),
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.4)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.ASCENT_COLOR, width: 1.4),
                    ),
                    hintText: 'task name',
                    hintStyle: TextStyle(color: AppColors.SECONDARY_HEADING),
                    border: const OutlineInputBorder()),
              ),
              const Spacing(height: 20),
              TextFormField(
                controller: descriptionController,
                cursorColor: AppColors.ASCENT_COLOR,
                style: TextStyle(color: AppColors.SECONDARY_HEADING),
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.4)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.ASCENT_COLOR, width: 1.4),
                    ),
                    hintText: 'task description',
                    hintStyle: TextStyle(color: AppColors.SECONDARY_HEADING),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.ASCENT_COLOR)),
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('please enter task name and sescription')));
                      return;
                    }
                    addTask(context);
                    Navigator.pop(context);
                  },
                  child: const Text('ADD TASK'))
            ],
          ),
        ));
  }

  // add user
}
