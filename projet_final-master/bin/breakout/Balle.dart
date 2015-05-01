library bin;

import 'dart:math' as math;
import 'Forme.dart';

class Balle extends Forme{
  int x = 150;
  int y = 150;
  int dx = 2;
  int dy = 4;
  var ballcolor = "#FFFFFF";
  int ballr = 10;
  
  Balle() : super();
  
  void circle() {
    context.beginPath();
    context.arc(x, y, ballr, 0, math.PI*2, true);
    context.fillStyle = ballcolor;
    context.fill();
    context.closePath();
  }
  
  int getX() => x;
  int getY() => y;
  int getDx() => dx;
  int getDy() => dy;
  int getBallcolor() => ballcolor;
  int getBallr() => ballr;
}