import 'package:flutter/material.dart';
import 'package:task_manager/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback save;
  VoidCallback cancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.save,
      required this.cancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade500,
      content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a new task',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NButton(name: "Save", onClicked: save),
                  const SizedBox(
                    width: 8,
                  ),
                  NButton(name: "Cancel", onClicked: cancel)
                ],
              )
            ],
          )),
    );
  }
}
