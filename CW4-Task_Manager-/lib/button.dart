import 'package:flutter/material.dart';

class NButton extends StatelessWidget {
  final String name;
  VoidCallback onClicked;

  NButton({
    super.key,
    required this.name,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onClicked,
      child: Text(name),
      color: Colors.grey.shade500,
    );
  }
}
