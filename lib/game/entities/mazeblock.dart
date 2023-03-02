import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class MazeBlock extends PositionComponent with Tappable {
  final Paint paint;
  final Vector2 bsize;
  final Vector2 bpos;

  MazeBlock({required this.paint, required this.bsize, required this.bpos})
      : super(priority: 2);

  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    print("Tapped ${position} , ${size}");

    return true;
  }

  @override
  void onLoad() {
    size = bsize;
    position = bpos;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), paint);
    super.render(canvas);
  }
}
