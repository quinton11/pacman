import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PacMan extends PositionComponent with Tappable {
  var green = Paint()..color = Colors.amber.shade600;
  PacMan() : super(priority: 1) {
    position = Vector2(50, 50);
    size = Vector2(30, 30);
    anchor = Anchor.center;
  }

  @override
  bool onTapDown(TapDownInfo info) {
    print("Pac tapped");
    position.x += 5;
    return true;
  }

  @override
  void render(Canvas canvas) {
    //canvas.drawRect(size.toRect(), green);
    super.render(canvas);
  }
}
