import 'package:flutter/material.dart';
import 'package:task_manager/tasks.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) onChanged;
  final Function(Task) onDelete;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
  }) : super(key: key);

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color.fromARGB(255, 247, 55, 55);
      case 'Medium':
        return const Color.fromARGB(255, 243, 154, 37);
      case 'Low':
        return const Color.fromARGB(255, 88, 239, 166);
      default:
        return const Color.fromARGB(255, 7, 200, 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color priorityColor = getPriorityColor(task.priority);

    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value) {
          onChanged(task);
        },
        activeColor: Colors.cyanAccent,
        checkColor: Colors.grey,
      ),
      title: Text(
        task.name,
        style: TextStyle(
          color: Colors.cyanAccent,
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      subtitle: Text(
        'Priority: ${task.priority}',
        style: TextStyle(color: priorityColor),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        color: const Color.fromARGB(255, 24, 255, 82),
        onPressed: () => onDelete(task),
      ),
    );
  }
}
