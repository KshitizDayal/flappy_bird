import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game/pipe_position.dart';

import '../game/flappy_bird_game.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipeGroup();

  final _random = Random();

  @override
  FutureOr<void> onLoad() {
    position.x = gameRef.size.x;

    final heightminusground = gameRef.size.y - Constants.groundheight;
    final spacing = 100 + _random.nextDouble() * (heightminusground / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightminusground - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
        pipePosition: PipePosition.bottom,
        height: heightminusground - (centerY + spacing / 2),
      ),
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Constants.gameSpeed * dt;

    if (position.x < -60) {
      removeFromParent();
      updateScore();
      // print("removed");
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Constants.point);
  }
}
