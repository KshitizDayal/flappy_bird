import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

import '../constants.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Background();

  @override
  FutureOr<void> onLoad() async {
    final background = await Flame.images.load(Constants.backgorund);
    size = gameRef.size;
    sprite = Sprite(background);
    return super.onLoad();
  }
}
