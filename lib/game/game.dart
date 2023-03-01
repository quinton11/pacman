import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:pacman/game/entities/maze.dart';

import 'package:pacman/game/entities/pac.dart';

class PacGame extends FlameGame with HasTappables {
  @override
  Future<void> onLoad() async {
    //Init all init-ables :)
    add(PacMan());
    add(Maze());
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    print("On tap");
    super.onTapDown(pointerId, info);
  }
}
