import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

import 'spooky_item.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final AudioPlayer _bgmPlayer = AudioPlayer();
  List<Widget> _spookyItems = [];
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
    _generateSpookyItems();
  }

  @override
  void dispose() {
    _bgmPlayer.dispose();
    super.dispose();
  }

  Future<void> _playBackgroundMusic() async {
    try {
      await _bgmPlayer.setLoopMode(LoopMode.all);
      await _bgmPlayer.setAsset('assets/sounds/background.mp3');
      _bgmPlayer.play();
    } catch (e) {
      print('Error loading background music: $e');
    }
  }

  void _generateSpookyItems() {
    setState(() {
      _spookyItems = List.generate(10, (index) {
        bool isCorrect = index == _random.nextInt(10);
        bool isTrap = !isCorrect && _random.nextBool();
        return SpookyItem(
          key: UniqueKey(),
          isCorrect: isCorrect,
          isTrap: isTrap,
          onFound: _onItemFound,
        );
      });
    });
  }

  void _onItemFound(bool isCorrect) {
    if (isCorrect) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('🎃 You Found It!'),
        content: Text('Happy Halloween!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _generateSpookyItems();
            },
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 97, 25, 211),
      body: Stack(
        children: _spookyItems,
      ),
    );
  }
}
