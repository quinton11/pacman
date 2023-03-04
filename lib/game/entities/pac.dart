import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacman/game/entities/maze.dart';
import 'package:pacman/game/entities/mazespace.dart';

enum Direction {
  right,
  left,
  up,
  down,
  def,
}

enum CollideSide {
  right,
  left,
  up,
  down,
  def,
}

class PacMan extends PositionComponent
    with Tappable, KeyboardHandler, CollisionCallbacks, HasGameRef {
  var amber = Paint()..color = Colors.amber.shade600;
  var purple = Paint()..color = Colors.purple.shade700;
  final Vector2 bsize;
  final Vector2 bpos;
  final Vector2 mazePos;
  bool collided = false;
  bool move = false;
  double delta = 0;
  late Direction direction = Direction.def;
  late Direction prevDirection = Direction.def;

  double speed = 50;

  late RectangleHitbox hitb;
  late CollideSide collideSide = CollideSide.def;
  PacMan({required this.bsize, required this.bpos, required this.mazePos})
      : super(priority: 3);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    /* if (!collided) {
      print("Collided");
      collided = true;
      print(intersectionPoints);
      print(other.position);
      print(position);
      //print(hitb.position);
      print(mazePos);
      //print(game.size);
    } */
    super.onCollision(intersectionPoints, other);
  }

  bool topCollision(PositionComponent other, Vector2 point, double errMargin) {
    double pWorldY = position.y + mazePos.y;
    double oWorldY = other.y + mazePos.y;
    //Range
    bool greaterThan = point.y > (oWorldY + other.size.y) - errMargin;
    bool lessThan = point.y < pWorldY + errMargin;

    if (greaterThan && lessThan) {
      return true;
    }
    return false;
  }

  bool bottomCollision(
      PositionComponent other, Vector2 point, double errMargin) {
    double pWorldY = position.y + mazePos.y;
    double oWorldY = other.y + mazePos.y;
    //Range
    bool greaterThan = point.y > (pWorldY + size.y) - errMargin;
    bool lessThan = point.y < oWorldY + errMargin;

    if (greaterThan && lessThan) {
      return true;
    }

    return false;
  }

  bool rightCollision(
      PositionComponent other, Vector2 point, double errMargin) {
    double pWorldX = position.x + mazePos.x;
    double oWorldX = other.x + mazePos.x;

    bool greaterThan = point.x > (pWorldX + size.x) - errMargin;
    bool lessThan = point.x < oWorldX + errMargin;
    if (greaterThan && lessThan) {
      return true;
    }
    return false;
  }

  bool leftCollision(PositionComponent other, Vector2 point, double errMargin) {
    double pWorldX = position.x + mazePos.x;
    double oWorldX = other.x + mazePos.x;

    bool greaterThan = point.x > (oWorldX + other.size.x) - errMargin;
    bool lessThan = point.x < pWorldX + errMargin;
    if (greaterThan && lessThan) {
      return true;
    }
    return false;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    print("On Collision Start");
    double errorMargin = 1.2;
    double offset = .5;
    bool inCentre = false;
    intersectionPoints.forEach((point) {
      //top
      if (topCollision(other, point, errorMargin)) {
        print("Player collided top");
        print(direction.toString());
        print(prevDirection.toString());
        position.setValues(position.x, position.y + offset);

        //move = false;
        inCentre = (position.x + size.x / 2) >=
                (other.position.x + other.size.x / 2 - 1) &&
            (position.x + size.x / 2) <=
                (other.position.x + other.size.x / 2 + 1);
        if (inCentre) {
          print("In centre");
          move = false;
        } else {
          direction = prevDirection;
        }
      } else if (bottomCollision(other, point, errorMargin)) {
        position.setValues(position.x, position.y - offset);

        print("Player collided bottom");
        print(direction.toString());
        print(prevDirection.toString());
        //move = false;
        inCentre = (position.x + size.x / 2) >=
                (other.position.x + other.size.x / 2 - 1) &&
            (position.x + size.x / 2) <=
                (other.position.x + other.size.x / 2 + 1);
        if (inCentre) {
          print("In centre");
          move = false;
        } else {
          direction = prevDirection;
        }
      } else if (rightCollision(other, point, errorMargin)) {
        print("Player collided right");
        print(direction.toString());
        print(prevDirection.toString());
        position.setValues(position.x - offset, position.y);
        move = false;

        inCentre = (position.y + size.y / 2) >=
                (other.position.y + other.size.y / 2 - 1) &&
            (position.y + size.y / 2) <=
                (other.position.y + other.size.y / 2 + 1);
        if (inCentre) {
          print("In centre");
          move = false;
        } else {
          direction = prevDirection;
        }

        /* Check if position center x is within +-.5 of other center
        If so then set move to false else set direction to previous direction   */
      } else if (leftCollision(other, point, errorMargin)) {
        print("Player collided left");
        print(direction.toString());
        print(prevDirection.toString());
        position.setValues(position.x + offset, position.y);
        //move = false;
        inCentre = (position.y + size.y / 2) >=
                (other.position.y + other.size.y / 2 - 1) &&
            (position.y + size.y / 2) <=
                (other.position.y + other.size.y / 2 + 1);
        if (inCentre) {
          print("In centre");
          move = false;
        } else {
          direction = prevDirection;
        }
      }
    });
    super.onCollisionStart(intersectionPoints, other);
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

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    if (event.runtimeType == RawKeyDownEvent) {
      move = true;
      switch (event.logicalKey.keyLabel) {
        case "Arrow Left":
          if (direction != Direction.left) {
            prevDirection = direction;
          }

          direction = Direction.left;

          break;
        case "Arrow Right":
          if (direction != Direction.right) {
            prevDirection = direction;
          }

          direction = Direction.right;

          break;
        case "Arrow Up":
          if (direction != Direction.up) {
            prevDirection = direction;
          }

          direction = Direction.up;

          break;
        case "Arrow Down":
          if (direction != Direction.down) {
            prevDirection = direction;
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

    //check direction
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
    canvas.drawRect(
      hitb.size.toRect(),
      purple,
    );
    super.render(canvas);
  }
}
