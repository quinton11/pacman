import 'dart:ui';

import 'package:flame/components.dart';
import 'package:pacman/utils/scheme.dart';

class Maze extends PositionComponent with HasGameRef {
  late MazeScheme scheme;
  @override
  void onLoad() {
    scheme = MazeScheme();
    scheme.mazeToBinary();
    print(scheme.mazeBinary);
    print(scheme.lengthRow); //35
    print(scheme.lengthCol); //50
    game.size;
    //for each item we construct
    //a PositionComponent with size depending on screen size
    //and position fixed
  }

  @override
  void render(Canvas canvas) {
    //render all maze positions
    super.render(canvas);
  }

  void populateMaze() {
    //loop through mazeBinary and create
    //positionalComponent for each item and add to
  }
}

/* 600 width 800 height */
