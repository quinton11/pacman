import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';
import 'package:pacman/game/entities/movable.dart';
import 'package:pacman/utils/enums.dart';

class Ghost extends Movable with CollisionCallbacks, HasGameRef {
  final Vector2 pos;
  final Vector2 siz;
  late RectangleHitbox hitb;
  final Paint color;
  GhostState state = GhostState.scatter;

/* States:
      Scattered
      Chase
      Frightened
      Eaten */
  Ghost({required this.pos, required this.siz, required this.color});

  @override
  void onLoad() {
    hitb = RectangleHitbox();
    hitb.collisionType = CollisionType.passive;
    size = siz;
    position = pos;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
  }

  /* Set stated based on timer and previous state + interaction */
  /* Set targets of ghost and calculate direction */
  /*  */

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), color);
    super.render(canvas);
  }
}
