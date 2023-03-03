import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:pacman/game/entities/maze.dart';

class PacGame extends FlameGame
    with HasTappables, HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    //Init all init-ables :)
    add(Maze());
    //debugMode = true;
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    print("On tap");
    super.onTapDown(pointerId, info);
  }
}
