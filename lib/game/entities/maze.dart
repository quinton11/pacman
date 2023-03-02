import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/entities/mazeblock.dart';
import 'package:pacman/utils/scheme.dart';

class Maze extends PositionComponent with HasGameRef {
  late MazeScheme scheme;
  List<PositionComponent> mazebar = [];
  var blue = Paint()..color = Colors.blue.shade800;
  var indigo = Paint()..color = Colors.pink.shade800;
  var black = Paint()..color = Colors.black;

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
    /* test.position = Vector2(position.x + size.x / 2, position.y + size.y / 2);
    test.anchor = Anchor.center;
    test.size = Vector2(30, 30); */

    size = Vector2(600, 380);
    double sizesubx = (game.size.x / 2) - (size.x / 2);
    double sizesuby = (game.size.y / 2) - (size.y / 2);
    position = Vector2(sizesubx, sizesuby);

    populateMaze();

    //print(game.size);

    print(mazebar.length);
    print(mazebar[0].size);
    print(mazebar[0].position);
    print(mazebar[1].size);
    print(mazebar[1].position);
    print(mazebar[2].size);
    print(mazebar[2].position);
    //for each item we construct
    //a PositionComponent with size depending on screen size

    //and position fixed
  }

  @override
  void render(Canvas canvas) {
    //render all maze positions
    //PositionComponent comp;
    //canvas.drawRect(size.toRect(), indigo);

    //canvas.drawRect(test.size.toRect(), black);
    super.render(canvas);
  }

  void populateMaze() {
    //loop through mazeBinary and create
    List<int> row = [];
    PositionComponent poscomp;
    Vector2 pos = Vector2(0, 0);
    Vector2 siz = Vector2(size.x / scheme.lengthCol, size.y / scheme.lengthRow);
    for (int i = 0; i < scheme.mazeBinary.length; i++) {
      //positionalComponent for each item and add to

      row = scheme.mazeBinary[i];

      for (int j = 0; j < row.length; j++) {
        if (row[j] == 0) {
          poscomp = MazeBlock(paint: blue, bpos: pos, bsize: siz);
          mazebar.add(poscomp);

          //
          add(poscomp);
        }
        pos.setValues(siz.x + pos.x , pos.y);
      }
      //print(pos);
      pos.setValues(0, pos.y + siz.y );
    }
  }
}

/* 600 width 800 height */
