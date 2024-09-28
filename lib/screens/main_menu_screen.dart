import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = "mainMenu";
  const MainMenuScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return GestureDetector(
      onTap: () {
        game.overlays.remove("mainMenu");
        game.resumeEngine();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Constants.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Constants.message),
        ),
      ),
    );
  }
}
