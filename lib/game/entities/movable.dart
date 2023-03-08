import 'package:flame/components.dart';

class Movable extends PositionComponent {
  Movable() : super(priority: 3);
  bool topCollision(PositionComponent other, Vector2 point, double errMargin,
      Vector2 mazePos) {
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

  bool bottomCollision(PositionComponent other, Vector2 point, double errMargin,
      Vector2 mazePos) {
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

  bool rightCollision(PositionComponent other, Vector2 point, double errMargin,
      Vector2 mazePos) {
    double pWorldX = position.x + mazePos.x;
    double oWorldX = other.x + mazePos.x;

    bool greaterThan = point.x > (pWorldX + size.x) - errMargin;
    bool lessThan = point.x < oWorldX + errMargin;
    if (greaterThan && lessThan) {
      return true;
    }
    return false;
  }

  bool leftCollision(PositionComponent other, Vector2 point, double errMargin,
      Vector2 mazePos) {
    double pWorldX = position.x + mazePos.x;
    double oWorldX = other.x + mazePos.x;

    bool greaterThan = point.x > (oWorldX + other.size.x) - errMargin;
    bool lessThan = point.x < pWorldX + errMargin;
    if (greaterThan && lessThan) {
      return true;
    }
    return false;
  }
}
