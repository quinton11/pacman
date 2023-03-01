import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pacman/game/game.dart';

void main() {
  final pacgame = PacGame();
  //runApp(const MyApp());
  runApp(
    GameWidget(
      game: pacgame,
    ),
  );
}
