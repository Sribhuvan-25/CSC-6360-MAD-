import 'package:flutter/material.dart';
import 'package:task_manager/tasks.dart';
import 'package:task_manager/task_item.dart';

class TaskListScreen extends StatefulWidget {
  TaskListScreen({Key? key}) : super(key: key);
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();
  String selectedPriority = 'Low';
  final List<String> priorities = ['High', 'Medium', 'Low'];

  void addTask() {
    String taskName = taskController.text.trim();
    if (taskName.isNotEmpty) {
      setState(() {
        tasks.add(Task(
          name: taskName,
          priority: selectedPriority,
        ));
        sortTasksByPriority();
        taskController.clear();
        selectedPriority = 'Low';
      });
    }
  }

  void toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void removeTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void sortTasksByPriority() {
    tasks.sort((a, b) {
      int priorityValue(String priority) {
        switch (priority) {
          case 'High':
            return 3;
          case 'Medium':
            return 2;
          case 'Low':
            return 1;
          default:
            return 0;
        }
      }

      int aValue = priorityValue(a.priority);
      int bValue = priorityValue(b.priority);
      return bValue.compareTo(aValue); // Descending order
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Manager App'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                        labelText: 'Enter Task Name',
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedPriority,
                  items: priorities.map((String priority) {
                    return DropdownMenuItem<String>(
                        value: priority, child: Text(priority));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPriority = newValue ?? 'Low';
                    });
                  },
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text('Add'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Expanded(
                child: tasks.isEmpty
                    ? const Center(child: Text('No tasks added yet.'))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return TaskItem(
                            task: task,
                            onChanged: toggleTaskCompletion,
                            onDelete: removeTask,
                          );
                        },
                      ),
              ),
            ])));
  }
}
