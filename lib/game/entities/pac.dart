import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Direction {
  right,
  left,
  up,
  down,
}

class PacMan extends PositionComponent
    with Tappable, KeyboardHandler, CollisionCallbacks {
  var amber = Paint()..color = Colors.amber.shade600;

  final Vector2 bsize;
  final Vector2 bpos;
  bool move = false;
  late Direction now;
  double speed = 30;
  PacMan({required this.bsize, required this.bpos}) : super(priority: 1);

  @override
  void onLoad() {
    position = bpos;
    size = bsize;
    anchor = Anchor.topLeft;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    if (event.runtimeType == RawKeyDownEvent) {
      move = true;
      switch (event.logicalKey.keyLabel) {
        case "Arrow Left":
          print("Arrow Left pressed");
          now = Direction.left;
          break;
        case "Arrow Right":
          print("Arrow Right Pressed");
          now = Direction.right;

          break;
        case "Arrow Up":
          print("Arrow Up Pressed");
          now = Direction.up;

          break;
        case "Arrow Down":
          print('Arrow Down Pressed');
          now = Direction.down;
      }
    }

    return true;
  }

  @override
  void update(double dt) {
    //
    double dx = 0;
    double dy = 0;
    if (move) {
      //check direction
      switch (now) {
        case Direction.right:
          dx = speed * dt;
          break;
        case Direction.left:
          dx = -speed * dt;
          break;
        case Direction.up:
          dy = -speed * dt;
          break;
        case Direction.down:
          dy = speed * dt;
          break;
      }
      position.setValues(position.x + dx, position.y + dy);
    }
    super.update(dt);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    print("Pac tapped");
    //position.x += 5;
    return true;
  }

  @override
  void render(Canvas canvas) {
    //canvas.drawRect(size.toRect(), green);
    /* canvas.drawCircle(Offset(position.x + size.x / 2, position.y + size.y / 2),
        size.x / 2, amber); */
    canvas.drawRect(size.toRect(), amber);
    super.render(canvas);
  }
}
