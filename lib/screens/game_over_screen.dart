import 'package:flappy_bird/constants.dart';
import 'package:flutter/material.dart';

import '../game/flappy_bird_game.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = "gameOver";
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Score: ${game.bird.score}",
              style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Game",
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Image.asset(Constants.gameOver),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: restartGame,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                "Restart",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void restartGame() {
    game.bird.resetPosition();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
