import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacman/game/entities/cookie.dart';
import 'package:pacman/game/entities/maze.dart';
import 'package:pacman/game/entities/mazeblock.dart';
import 'package:pacman/game/entities/mazespace.dart';
import 'package:pacman/game/entities/movable.dart';
import 'package:pacman/utils/enums.dart';

class PacMan extends Movable
    with Tappable, KeyboardHandler, CollisionCallbacks, HasGameRef {
  var amber = Paint()..color = Colors.amber.shade600;
  var purple = Paint()..color = Colors.purple.shade700;
  final Vector2 bsize;
  final Vector2 bpos;
  final Vector2 mazePos;
  final Vector2 mazeSize;
  bool collided = false;
  bool move = true;
  bool start = true;
  double delta = 0;
  late Direction direction = Direction.def;
  late Direction prevDirection = Direction.def;

  double speed = 55;

  late RectangleHitbox hitb;
  late CollideSide collideSide = CollideSide.def;
  PacMan(
      {required this.bsize,
      required this.bpos,
      required this.mazePos,
      required this.mazeSize});

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    double errorMargin = 2;
    double offset = 1.8;
    double hitoff = 2;
    bool inCentre = false;
    if (other is MazeBlock) {
      print("On Collision Start");
      Vector2 point;
      for (int i = 0; i < intersectionPoints.length; i++) {
        point = intersectionPoints.elementAt(i);
        if (topCollision(other, point, errorMargin, mazePos)) {
          print("Player collided top");
          //move = false;
          //break;
          offset = other.position.y + other.size.y + 1;
          inCentre = (position.x + size.x / 2) >=
                  (other.position.x + other.size.x / 2 - hitoff) &&
              (position.x + size.x / 2) <=
                  (other.position.x + other.size.x / 2 + hitoff);
          if (inCentre) {
            print("In centre");
            move = false;
            collided = true;
          } else {
            direction = prevDirection;
          }
          position.setValues(position.x, offset);

          break;
        } else if (bottomCollision(other, point, errorMargin, mazePos)) {
          print("Player collided bottom");
          //move = false;
          //break;
          offset = other.position.y - other.size.y - 1;

          inCentre = (position.x + size.x / 2) >=
                  (other.position.x + other.size.x / 2 - hitoff) &&
              (position.x + size.x / 2) <=
                  (other.position.x + other.size.x / 2 + hitoff);
          if (inCentre) {
            print("In centre");
            move = false;
            collided = true;
          } else {
            direction = prevDirection;
          }
          position.setValues(position.x, offset);

          break;
        } else if (rightCollision(other, point, errorMargin, mazePos)) {
          print("Player collided right");
          //move = false;
          //break;
          offset = other.position.x - other.size.x - 1;

          inCentre = (position.y + size.y / 2) >=
                  (other.position.y + other.size.y / 2 - hitoff) &&
              (position.y + size.y / 2) <=
                  (other.position.y + other.size.y / 2 + hitoff);
          if (inCentre) {
            print("In centre");
            move = false;
            collided = true;
          } else {
            direction = prevDirection;
          }
          position.setValues(offset, position.y);

          break;
        } else if (leftCollision(other, point, errorMargin, mazePos)) {
          print("Player collided left");
          //move = false;
          //break;
          offset = other.position.x + other.size.x + 1;

          inCentre = (position.y + size.y / 2) >=
                  (other.position.y + other.size.y / 2 - hitoff) &&
              (position.y + size.y / 2) <=
                  (other.position.y + other.size.y / 2 + hitoff);
          if (inCentre) {
            print("In centre");
            move = false;
            collided = true;
          } else {
            direction = prevDirection;
          }
          position.setValues(offset, position.y);

          break;
        }
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Cookie) {
      parent!.remove(other);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onLoad() {
    position = bpos;
    size = bsize;
    anchor = Anchor.topLeft;
    hitb = RectangleHitbox();
    hitb.collisionType = CollisionType.active;
    purple.style = PaintingStyle.stroke;
    add(hitb);
  }

  void edge() {
    if (position.x <= 0) {
      position.x = mazeSize.x - 1;
    } else if (position.x + size.x >= mazeSize.x) {
      position.x = 1;
    } else if (position.y + size.y >= mazeSize.y) {
      position.y = 1;
    } else if (position.y <= 0) {
      position.y = mazeSize.y - 1;
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    if (event.runtimeType == RawKeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case "Arrow Left":
          if (direction != Direction.left) {
            move = true;
            prevDirection = direction;
            print("Moving");

            //viableSpace();
          }

          direction = Direction.left;

          break;
        case "Arrow Right":
          if (direction != Direction.right) {
            move = true;

            prevDirection = direction;
            print("Moving");
          }

          direction = Direction.right;

          break;
        case "Arrow Up":
          if (direction != Direction.up) {
            move = true;

            prevDirection = direction;
            print("Moving");

            //viableSpace();
          }

          direction = Direction.up;

          break;
        case "Arrow Down":
          if (direction != Direction.down) {
            prevDirection = direction;
            move = true;

            print("Moving");
            //viableSpace();
          }

          direction = Direction.down;
      }
    }

    return true;
  }

  @override
  void update(double dt) {
    //
    double dx = 0;
    double dy = 0;
    delta = dt;

    /* Always centre pacman, if collided, set position to previous centre */

    //check direction
    //edge();
    if (move) {
      switch (direction) {
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
        case Direction.def:
          break;
      }
    }

    position.setValues(position.x + dx, position.y + dy);

    //move = true;
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
    canvas.drawRect(size.toRect(), amber);

    super.render(canvas);
  }
}
