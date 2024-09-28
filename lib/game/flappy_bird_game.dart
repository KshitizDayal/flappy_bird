import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flappy_bird/constants.dart';

import '../components/background.dart';
import '../components/bird.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  Timer interval = Timer(Constants.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;

  @override
  FutureOr<void> onLoad() {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      PipeGroup(),
      score = builScore(),
    ]);
    interval.onTick = () => add(PipeGroup());
    return super.onLoad();
  }

  TextComponent builScore() {
    return TextComponent(
      text: "Score: 0",
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: "Game",
        ),
      ),
    );
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = "Score: ${bird.score}";
  }
}
