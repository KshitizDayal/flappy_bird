import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flutter/material.dart';

import '../game/bird_movement.dart';
import '../game/flappy_bird_game.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  @override
  FutureOr<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Constants.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Constants.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Constants.birdDownFlap);

    size = Vector2(50, 40);
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };
    current = BirdMovement.middle;
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    add(CircleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Constants.birdVelocity * dt;

    if (position.y < 1) {
      gameOver();
    }
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Constants.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    current = BirdMovement.up;
    FlameAudio.play(Constants.flying);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void gameOver() {
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
    game.isHit = true;
    FlameAudio.play(Constants.collision);
  }

  void resetPosition() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }
}
