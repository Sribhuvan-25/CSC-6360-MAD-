import 'dart:math';
import 'package:calculator_app/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => CalculatorAppState();
}

class CalculatorAppState extends State<CalculatorApp> {
  var userInput = '';
  var result = '0';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Calculator'),
        ),
        backgroundColor: Colors.blueGrey.shade800,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // User input display
            SizedBox(
              height: 120,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    userInput,
                    style: const TextStyle(fontSize: 24, color: Colors.white30),
                  ),
                ),
              ),
            ),
            // Result display
            SizedBox(
              height: 100,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                padding: const EdgeInsets.all(8.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: [
                  CalculatorButton(
                    text: 'AC',
                    fillColor: Colors.blueGrey.shade500,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput = '';
                        result = '0';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '÷',
                    fillColor: Colors.blueGrey.shade400,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '/';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: 'x',
                    fillColor: Colors.blueGrey.shade400,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += 'x';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '-',
                    fillColor: Colors.blueGrey.shade400,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '-';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '+',
                    fillColor: Colors.blueGrey.shade400,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '+';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '7',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '7';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '8',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '8';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '9',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '9';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '4',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '4';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '5',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '5';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '6',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '6';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '1',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '1';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '2',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '2';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '3',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '3';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '0',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        userInput += '0';
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '.',
                    fillColor: Colors.black,
                    height: 60,
                    width: 60,
                    onPressed: () {
                      setState(() {
                        // Prevent multiple decimal points in a single number
                        if (!userInput.endsWith('.')) {
                          userInput += '.';
                        }
                      });
                    },
                  ),
                  CalculatorButton(
                    text: '=',
                    fillColor: Colors.blueGrey.shade400,
                    height: 60,
                    width: double.infinity,
                    onPressed: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = finaluserinput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    result = eval.toStringAsFixed(6);
    result = result.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }
}
