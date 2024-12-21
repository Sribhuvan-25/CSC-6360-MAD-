import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Color fillColor;
  final VoidCallback onPressed;

  CalculatorButton({
    required this.text,
    required this.height,
    required this.width,
    required this.fillColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
