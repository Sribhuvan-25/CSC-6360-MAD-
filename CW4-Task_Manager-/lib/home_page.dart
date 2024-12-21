import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/data.dart';
import 'package:task_manager/dialog_box.dart';
import 'package:task_manager/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('Box');
  TaskManagerData data = TaskManagerData();

  @override
  void initState() {
    if (myBox.get('Tasks') == null) {
      data.createInitialData();
    } else {
      data.loadData();
    }
    super.initState();
  }

  final controller = TextEditingController();

  void checkboxClicked(bool? value, int index) {
    setState(() {
      data.tasks[index][1] = !data.tasks[index][1];
    });
    data.updateData();
  }

  void saveNewTask() {
    setState(() {
      data.tasks.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    data.updateData();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: controller,
          save: saveNewTask,
          cancel: () => Navigator.of(context).pop(),
        );
      },
    );
    data.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      data.tasks.removeAt(index);
    });
    data.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Task Manager'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade500,
        onPressed: createTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: data.tasks.length,
        itemBuilder: (context, index) {
          return TodoTile(
            onClicked: (value) => checkboxClicked(value, index),
            taskCompleted: data.tasks[index][1],
            taskName: data.tasks[index][0],
            deleteTask: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
