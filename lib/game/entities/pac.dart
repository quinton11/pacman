import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'package:flame/collisions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacman/game/entities/mazeblock.dart';
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
    with Tappable, KeyboardHandler, CollisionCallbacks {
  var amber = Paint()..color = Colors.amber.shade600;
  var purple = Paint()..color = Colors.purple.shade700;
  final Vector2 bsize;
  final Vector2 bpos;
  bool collided = false;
  bool move = false;
  late Direction direction = Direction.def;
  late Direction nextDirection = Direction.def;
  late Direction prevDirection = Direction.def;
  double speed = 80;

  late RectangleHitbox hitb;
  late CollideSide collideSide = CollideSide.def;
  PacMan({required this.bsize, required this.bpos}) : super(priority: 3);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    direction = Direction.def;
    position.setValues(position.x, position.y);
    /* check if collision centre is within others */
    /* check if desired points x,y points are within others bounds
    If so then revert to previous movement or stop moving If */

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (collided) {
      collided = false;
      collideSide = CollideSide.def;
    }
    super.onCollisionEnd(other);
  }

  bool hitTB(PositionComponent other) {
    /* Check if pacman's top left x or top right x is within the collided bodies topleftx+width */
    bool tlwithin = (position.x >= other.position.x &&
            position.x <= other.position.x + other.size.x) ||
        (position.x + size.x >= other.position.x &&
            position.x + size.x <= other.position.x + other.size.x);

    return tlwithin;
  }

  bool hitLR(PositionComponent other) {
    /* Check if pacman's top left y or bottom left-y is within the collided bodies toplefty+height */
    bool lrwithin = (position.y >= other.position.y &&
            position.y <= other.position.y + other.size.y) ||
        (position.y + size.y >= other.position.y &&
            position.y + size.y <= other.position.y + other.size.y);
    return lrwithin;
  }

  bool collisionSide(PositionComponent other) {
    bool desiredOccupied = false;
    //check for direction

    if (nextDirection == Direction.up) {
      desiredOccupied = hitTB(other);

      print("Top");
      collideSide = CollideSide.up;
      /* Check if pacman's top left x or top right x is within the collided bodies topleftx+width */
    }
    if (nextDirection == Direction.down) {
      desiredOccupied = hitTB(other);

      print("Bottom");
      collideSide = CollideSide.down;
    }
    if (nextDirection == Direction.left) {
      desiredOccupied = hitLR(other);
      print("Left");
      collideSide = CollideSide.left;
    }
    if (nextDirection == Direction.right) {
      desiredOccupied = hitLR(other);
      print("Right");
      collideSide = CollideSide.right;
    }

    return desiredOccupied;
  }

  @override
  void onLoad() {
    position = bpos;
    size = bsize;
    anchor = Anchor.topLeft;
    hitb = RectangleHitbox();
    purple.style = PaintingStyle.stroke;
    add(hitb);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    

    if (event.runtimeType == RawKeyDownEvent) {
      //move = true;
      prevDirection = direction;

      switch (event.logicalKey.keyLabel) {
        case "Arrow Left":
          direction = Direction.left;
          nextDirection = Direction.left;
      

          break;
        case "Arrow Right":
          direction = Direction.right;
          nextDirection = Direction.right;

          break;
        case "Arrow Up":
          direction = Direction.up;
          nextDirection = Direction.up;
          

          break;
        case "Arrow Down":
          direction = Direction.down;
          nextDirection = Direction.down;
        
      }
    }
    

    return true;
  }

  @override
  void update(double dt) {
    //
    double dx = 0;
    double dy = 0;
    
    //check direction
    /* if there is a collission, change direction to prev direction */
    switch (direction) {
      case Direction.right:
        if (collideSide != CollideSide.right) {
          dx = speed * dt;
        }
        break;
      case Direction.left:
        if (collideSide != CollideSide.left) {
          dx = -speed * dt;
        }
        break;
      case Direction.up:
        if (collideSide != CollideSide.up) {
          dy = -speed * dt;
        }
        break;
      case Direction.down:
        if (collideSide != CollideSide.down) {
          dy = speed * dt;
        }
        break;
      case Direction.def:
        break;
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
