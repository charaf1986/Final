library control;

import 'dart:html';
import 'dart:async';
import '../bin/breakout/Balle.dart';
import '../bin/breakout/Barre.dart';
import '../bin/breakout/briques/Brique.dart';

class BreakoutControl {
  Balle balle;
  Barre barre;
  Brique brique;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  int WIDTH;
  int HEIGHT;
  Timer t;
  var backcolor = "#000000";
  int speed=10;
  
  BreakoutControl(){
  canvas = document.querySelector('#canvas');
  context = canvas.getContext('2d');
  WIDTH = canvas.width;
  HEIGHT = canvas.height;
  balle = new Balle();
  barre = new Barre();
  brique = new Brique();
  }
  
  void clear() {
    context.beginPath();
    context.clearRect(0,0,WIDTH,HEIGHT);
    context.rect(0,0,WIDTH,HEIGHT);
    context.fillStyle = backcolor;
    context.fill();
    context.closePath();
  }

  void draw() {
    clear();
    balle.circle();
//move the paddle if left or right is currently pressed
    if (barre.rightDown) barre.paddlex += 5;
    else if (barre.leftDown) barre.paddlex -= 5;
    barre.rect(barre.paddlex, HEIGHT-barre.paddleh, barre.paddlew, barre.paddleh);
    
    
    brique.briques(barre);
    
    //have we hit a brick?
    var rowheight = brique.BRICKHEIGHT + brique.PADDING;
    var colwidth = brique.BRICKWIDTH + brique.PADDING;
    var row = (balle.y/rowheight).floor();
    var col = (balle.x/colwidth).floor();
    //if so, reverse the ball and mark the brick as broken
    if (balle.y < brique.NROWS * rowheight && row >= 0 && col >= 0 && brique.bricks[row][col] == 1) {
      balle.dy = -balle.dy;
      brique.bricks[row][col] = 0;
    }
    
    if (balle.x + balle.dx > WIDTH || balle.x + balle.dx < 0)
      balle.dx = -balle.dx;
    
    if (balle.y + balle.dy < 0)
      balle.dy = -balle.dy;
    else if (balle.y + balle.dy > HEIGHT) {
      if (balle.x > barre.paddlex && balle.x < barre.paddlex + barre.paddlew)
        balle.dy = -balle.dy;
      else
      {
        //game over, so stop the animation
        stop();
      }
    }
    
    balle.x += balle.dx;
    balle.y += balle.dy;
  }
  
  void repeat(int i){
    Duration tick1 = new Duration(milliseconds: balle.ballr);
    if (i==0)
    {
      draw();
    }
    else
    {
      t = new Timer.periodic(tick1, (timer){
        draw();
      });
    }
  }
  
  void stop(){
     t.cancel();
     window.alert("End game");
  }
  
  void pause(){
     t.cancel();
    }
}
