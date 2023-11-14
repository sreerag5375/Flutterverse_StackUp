import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/screens/screen_create_account.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/widgets/spacing.dart';

class EditScreen extends StatelessWidget {
  String id;
  String title;
  String description;
  String update;
  EditScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.update});

  final CollectionReference task =
      FirebaseFirestore.instance.collection('task');

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    descriptionController.text = description;
    titleController.text = title;
    return Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        appBar: AppBar(
          title: const Text('Update Task'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.ASCENT_COLOR,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacing(height: 20),
              TextField(
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
              TextField(
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
                    hintText: 'description',
                    hintStyle: TextStyle(color: AppColors.SECONDARY_HEADING),
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    updateData();
                    Navigator.pop(context);
                  },
                  child: const Text('UPDATE'))
            ],
          ),
        ));
  }

  Future<void> updateData() async {
    final username = await getString(stringKey: "username");
    DocumentReference userDocument = task.doc(username);
    CollectionReference userTasks = userDocument.collection("nodeCollection");
    await userTasks.doc(id).update({
      "description": descriptionController.text,
      "title": titleController.text
    });
  }
}
