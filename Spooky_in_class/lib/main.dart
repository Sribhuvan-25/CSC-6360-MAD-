// Abhinav Kompella
// Sribhuvan Reddy Yellu
// Hydervali Yalamkur

import 'package:flutter/material.dart';
import 'package:in_class_group_challenge/game_screen.dart';
void main() {
  runApp(HalloweenGame());
}

class HalloweenGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halloween Game',
      theme: ThemeData.dark(),
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
