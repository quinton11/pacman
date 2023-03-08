import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class MazeSpace extends PositionComponent with Tappable, CollisionCallbacks {
  final Paint paint;
  final Vector2 bsize;
  final Vector2 bpos;
  //late RectangleHitbox hitb;
  var purple = Paint()..color = Colors.purple.shade700;

  MazeSpace({required this.paint, required this.bsize, required this.bpos})
      : super(priority: 2);

  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    print(toString());
    print("Tapped ${position} , ${size}");

    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //print(other.toString());
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onLoad() {
    size = bsize;
    position = bpos;
    //hitb = RectangleHitbox();
    //hitb.isSolid = true;
    //add(hitb);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), paint);
    //canvas.drawRect(hitb.size.toRect(), purple);
    super.render(canvas);
  }
}
