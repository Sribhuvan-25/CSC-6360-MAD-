import 'package:flutter/material.dart';
import 'task_list_screen.dart';

void main() => runApp(TaskManagerApp());

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey.shade800,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.black,
          secondary:
              const Color.fromARGB(255, 15, 156, 88), // Replaces accentColor
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: const Color.fromARGB(255, 24, 255, 128)),
          bodyText2: TextStyle(color: const Color.fromARGB(255, 24, 255, 143)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: const Color.fromARGB(255, 24, 255, 163)),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 24, 255, 166)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 24, 255, 147)),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 24, 255, 182)),
        ),
        iconTheme: IconThemeData(
          color: Colors.cyanAccent,
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(color: Colors.black),
        ),
      ),
      home: TaskListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
