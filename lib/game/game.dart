import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
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
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Colors.grey.shade700;
  }

  /* @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), background)
    super.render(canvas);
  } */

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    print("On tap");
    super.onTapDown(pointerId, info);
  }
}
