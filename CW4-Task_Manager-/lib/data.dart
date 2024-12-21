import 'package:hive/hive.dart';
import 'package:task_manager/main.dart';
import 'package:firebase_database/firebase_database.dart';

class Task {
  final String title;
  bool isCompleted;
  List<Task> subTasks;

  Task(
      {required this.title, required this.isCompleted, required this.subTasks});
}

class TMD {
  List<Task> tasks = [];

  final myBox = Hive.box('Box');

  void createInitialData() {
    tasks = [
      Task(title: 'Task 1', isCompleted: false, subTasks: []),
      Task(title: 'Task 1', isCompleted: false, subTasks: []),
    ];
  }

  // void loadTasks() {
  //   tasks = myBox.get('Tasks');
  // }

  void loadTasks() {
    tasks = myBox.get('Tasks', defaultValue: [])?.cast<Task>() ?? [];
  }

  void updateTasks() {
    myBox.put('Tasks', tasks);
  }
}

class TaskManagerData {
  List tasks = [];

  final myBox = Hive.box('Box');

  void createInitialData() {
    tasks = [
      ['Task 1', false],
      ['Task 2', false]
    ];
  }

  void loadData() {
    tasks = myBox.get('Tasks');
  }

  void updateData() {
    myBox.put('Tasks', tasks);
  }
}
