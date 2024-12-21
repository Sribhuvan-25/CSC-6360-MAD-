import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';

class SpookyItem extends StatefulWidget {
  final bool isCorrect;
  final bool isTrap;
  final Function(bool) onFound;

  SpookyItem({required Key key, required this.isCorrect, required this.isTrap, required this.onFound}) : super(key: key);

  @override
  _SpookyItemState createState() => _SpookyItemState();
}

class _SpookyItemState extends State<SpookyItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Random _random = Random();

  // Audio players for sound effects
  final AudioPlayer _soundPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _random.nextInt(3) + 2),
    )..repeat(reverse: true);

    // Random movement animation
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(_random.nextDouble() * 2 - 0.1, _random.nextDouble() * 2 - 0.1),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _soundPlayer.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (widget.isTrap) {
      await _playSound('assets/sounds/jump_scare.mp3');
      // Optional: Display a jump scare overlay
    } else if (widget.isCorrect) {
      await _playSound('assets/sounds/success.mp3');
      widget.onFound(true);
    } else {
      // Optional: Play a neutral sound or do nothing
    }
  }

  Future<void> _playSound(String assetPath) async {
    try {
      await _soundPlayer.setAsset(assetPath);
      _soundPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = 50.0 + _random.nextDouble() * 50;
    String imageAsset;

    if (widget.isCorrect) {
      imageAsset = 'assets/images/pumpkin.png';
    } else if (widget.isTrap) {
      imageAsset = 'assets/images/ghost.png';
    } else {
      imageAsset = 'assets/images/bat.png';
    }

    return Positioned(
      left: _random.nextDouble() * (MediaQuery.of(context).size.width - size),
      top: _random.nextDouble() * (MediaQuery.of(context).size.height - size),
      child: SlideTransition(
        position: _animation,
        child: GestureDetector(
          onTap: _handleTap,
          child: Image.asset(
            imageAsset,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
