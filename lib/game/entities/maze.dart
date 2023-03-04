import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/entities/mazeblock.dart';
import 'package:pacman/game/entities/mazespace.dart';
import 'package:pacman/game/entities/pac.dart';
import 'package:pacman/utils/scheme.dart';

class Maze extends PositionComponent with HasGameRef {
  late MazeScheme scheme;
  List<PositionComponent> mazebar = [];
  static List<PositionComponent> mazespace = [];

  var blue = Paint()..color = Colors.blue.shade800;
  var indigo = Paint()..color = Colors.pink.shade800;
  var black = Paint()..color = Colors.black;
  var yellow = Paint()..color = Colors.yellow.shade700;
  var grey = Paint()..color = Colors.black54;

  Maze();

  @override
  void onLoad() {
    scheme = MazeScheme();
    scheme.mazeToBinary();
    //print(scheme.mazeBinary);
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

    super.render(canvas);
  }

  void populateMaze() {
    //loop through mazeBinary and create
    List<int> row = [];
    PositionComponent poscomp;
    Vector2 pos = Vector2(0, 0);
    Vector2 siz =
        Vector2((size.x / scheme.lengthCol), (size.y / scheme.lengthRow));
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
          );
          mazebar.add(poscomp);

          //
          add(poscomp);
        } else if (row[j] == 1) {
          poscomp = MazeSpace(
              bpos: Vector2(pos.x, pos.y),
              bsize: Vector2(siz.x, siz.y),
              paint: grey);
          mazespace.add(poscomp);
          //add(poscomp);
        }
        pos.setValues(siz.x + pos.x + 1, pos.y);
      }
      //print(pos);
      pos.setValues(0, pos.y + siz.y + 1);
    }
  }
}

/* 600 width 800 height */
