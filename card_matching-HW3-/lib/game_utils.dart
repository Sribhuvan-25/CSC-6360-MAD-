import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "assets/images/question.png";
  List<String> cards_list = [
    "assets/images/panda.png",
    "assets/images/rabbit.png",
    "assets/images/panda.png",
    "assets/images/parrot.png",
    "assets/images/zoo.png",
    "assets/images/rabbit.png",
    "assets/images/zoo.png",
    "assets/images/parrot.png",
  ];
  final int cardCount = 8;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
