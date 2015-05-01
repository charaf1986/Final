library briques;

import '../Barre.dart';
import '../Forme.dart';

class Brique extends Forme{
  var bricks;
  var NROWS;
  var NCOLS;
  var BRICKWIDTH;
  var BRICKHEIGHT;
  var PADDING;

  var rowcolors = ["#FF1C0A", "#FFFD0A", "#00A308", "#0008DB", "#EB0093"];
  
  Brique() : super(){    
    NROWS=5;
    NCOLS=5;
    BRICKWIDTH = (WIDTH/NCOLS) - 1;
    BRICKHEIGHT = 15;
    PADDING = 1;

    bricks = new List(NROWS+1);
    for (int i=0; i < NROWS; i++) {
      bricks[i] = new List(NCOLS+1);
      for (int j=0; j < NCOLS; j++) {
        bricks[i][j] = 1;
      }
    }
  }
  
  void briques(Barre barre){
    for (int i=0; i < NROWS; i++) {
      for (int j=0; j < NCOLS; j++) {
        if (bricks[i][j] == 1) {
          rect((j * (BRICKWIDTH + PADDING)) + PADDING, 
              (i * (BRICKHEIGHT + PADDING)) + PADDING,
              BRICKWIDTH, BRICKHEIGHT,rowcolors[i]);
        }
      }
    }
  }
  
  void rect(x,y,w,h,color) {
    context.beginPath();
    context.rect(x,y,w,h);
    context.fillStyle = color;
    context.fill();
    context.closePath();
  }
  
  getBricks() => bricks;
  getNROWS() => NROWS;
  getNCOLS() => NCOLS;
  getBRICKWIDTH() => BRICKWIDTH;
  getBRICKHEIGHT() => BRICKHEIGHT;
  getPADDING() => PADDING;
}