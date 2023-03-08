import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/entities/cookie.dart';
import 'package:pacman/game/entities/ghost.dart';
import 'package:pacman/game/entities/mazeblock.dart';
import 'package:pacman/game/entities/mazespace.dart';
import 'package:pacman/game/entities/pac.dart';
import 'package:pacman/utils/scheme.dart';

class Maze extends PositionComponent with HasGameRef {
  late MazeScheme scheme;
  static List<PositionComponent> mazebar = [];
  static List<PositionComponent> mazespace = [];

  var blue = Paint()..color = const Color.fromARGB(255, 8, 52, 107);
  var indigo = Paint()..color = Colors.pink.shade800;
  //var black = Paint()..color = Colors.black;
  var purple = Paint()..color = Colors.purple.shade900;
  var red = Paint()..color = Colors.red.shade800;
  var green = Paint()..color = Colors.green.shade800;
  var white = Paint()..color = Colors.white;
  var teal = Paint()..color = Colors.tealAccent.shade700;
  var lime = Paint()..color = Colors.lime.shade600;

  late RectangleHitbox hitb;

  Maze();

  @override
  void onLoad() {
    scheme = MazeScheme();
    scheme.mazeToBinary();

    print(scheme.lengthRow); //35
    print(scheme.lengthCol); //50
    //game.size;
    anchor = Anchor.topLeft;
    print(game.size);
    print(game.canvasSize);

    size = Vector2(600, 380);
    double sizesubx = (game.size.x / 2) - (size.x / 2);
    double sizesuby = (game.size.y / 2) - (size.y / 2);
    position = Vector2(sizesubx, sizesuby);

    populateMaze();
  }

  @override
  void render(Canvas canvas) {
    //render all maze positions
    //canvas.drawRect(hitb.size.toRect(), purple);
    super.render(canvas);
  }

  void populateMaze() {
    //loop through mazeBinary and create
    List<int> row = [];
    PositionComponent poscomp;
    Vector2 pos = Vector2(0, 0);
    /* Vector2 siz =
        Vector2((size.x / scheme.lengthCol), (size.y / scheme.lengthRow)); */
    Vector2 siz = Vector2(12, 10);
    for (int i = 0; i < scheme.mazeBinary.length; i++) {
      //positionalComponent for each item and add to

      row = scheme.mazeBinary[i];

      for (int j = 0; j < row.length; j++) {
        if (row[j] == 0) {
          poscomp = MazeBlock(
            paint: blue,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 2) {
          poscomp = PacMan(
            bpos: Vector2(pos.x, pos.y),
            bsize: Vector2(siz.x, siz.y),
            mazePos: position,
            mazeSize: size,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 1) {
          poscomp = Cookie(
              pos: Vector2(pos.x + (siz.x / 2) - 1, pos.y + (siz.y / 2) - 1),
              siz: Vector2(3, 3));

          add(poscomp);
        } else if (row[j] == 4) {
          poscomp = MazeBlock(
            paint: red,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 5) {
          poscomp = MazeBlock(
            paint: green,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 6) {
          poscomp = MazeBlock(
            paint: purple,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 7) {
          poscomp = MazeBlock(
            paint: indigo,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 8) {
          poscomp = MazeBlock(
            paint: lime,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 9) {
          poscomp = MazeBlock(
            paint: teal,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 10) {
          poscomp = MazeBlock(
            paint: white,
            bpos: pos,
            bsize: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 11) {
          poscomp = Ghost(
            color: white,
            pos: pos,
            siz: siz,
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        }
        pos.setValues(siz.x + pos.x + 1, pos.y);
      }
      //print(pos);
      pos.setValues(0, pos.y + siz.y + 1);
    }
  }
}
