import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/pipe_position.dart';

import '../constants.dart';
import '../game/flappy_bird_game.dart';

class Pipe extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Pipe({
    required this.pipePosition,
    required this.height,
  });

  @override
  final double height;
  final PipePosition pipePosition;

  @override
  Future<void> onLoad() async {
    final pipe = await Flame.images.load(Constants.pipe);
    final pipeRotated = await Flame.images.load(Constants.pipeRotated);
    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - Constants.groundheight;
        sprite = Sprite(pipe);
        break;
    }

    add(RectangleHitbox());
  }
}
