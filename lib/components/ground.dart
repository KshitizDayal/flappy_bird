import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';

import '../constants.dart';
import '../game/flappy_bird_game.dart';

class Ground extends ParallaxComponent<FlappyBirdGame>
    with HasGameRef<FlappyBirdGame> {
  Ground();

  @override
  FutureOr<void> onLoad() async {
    final ground = await Flame.images.load(Constants.ground);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none),
      ),
    ]);

    add(
      RectangleHitbox(
        position: Vector2(0, gameRef.size.y - Constants.groundheight),
        size: Vector2(gameRef.size.x, Constants.groundheight),
      ),
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax!.baseVelocity.x = Constants.gameSpeed;
  }
}
