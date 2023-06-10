import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
//import 'package:pacman/game/entities/pac.dart';

class Cookie extends PositionComponent with CollisionCallbacks {
  final Vector2 pos;
  final Vector2 siz;
  late RectangleHitbox hitb;
  var gold = Paint()..color = Colors.amber.shade900;
  Cookie({required this.pos, required this.siz});

  @override
  void onLoad() {
    position = pos;
    size = siz;

    hitb = RectangleHitbox();
    hitb.collisionType = CollisionType.passive;
    add(hitb);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    /* if (other is PacMan) {
      print("Cookie collided with pacman");
      //remove(this);
    } */
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), gold);
    super.render(canvas);
  }
}
