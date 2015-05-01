
import 'dart:html';
import 'Forme.dart';

class Barre extends Forme{
  var paddlex;
  int paddleh;
  int paddlew;
  bool rightDown = false;
  bool leftDown = false;
  var canvasMinX;
  var canvasMaxX;
  var paddlecolor = "#FFFFFF";
  
  Barre() : super(){
    paddlex = WIDTH / 2;
    paddleh = 10;
    paddlew = 75;
    canvasMinX = document.querySelector('#canvas').offset.left;
    canvasMaxX = canvasMinX + WIDTH;
    window.onKeyDown.listen(onKeyDown);
    window.onKeyUp.listen(onKeyUp);
    window.onMouseMove.listen(onMouseMove);
  }
  
  void rect(x,y,w,h) {
    context.beginPath();
    context.rect(x,y,w,h);
    context.fillStyle = paddlecolor;
    context.fill();
    context.closePath();
  }
  
  void onKeyDown(evt) {
    if (evt.keyCode == 39) rightDown = true;
    else if (evt.keyCode == 37) leftDown = true;
  }

  void onKeyUp(evt) {
    if (evt.keyCode == 39) rightDown = false;
    else if (evt.keyCode == 37) leftDown = false;
  }
  
  void onMouseMove(MouseEvent evt) {
    if (evt.page.x > canvasMinX && evt.page.x < canvasMaxX) {
      paddlex = evt.page.x - canvasMinX;
    }
  }
  
  getPaddlex() => paddlex;
  getPaddleh() => paddleh;
  getPaddlew() => paddlew;
  getRightDown() => rightDown;
  getLeftDown() => leftDown;
  getPaddlecolor() => paddlecolor;
}
