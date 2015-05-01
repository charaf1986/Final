library bin;

import 'dart:html';

class Forme {
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  int WIDTH;
  int HEIGHT;
  
  Forme(){
    canvas = document.querySelector('#canvas');
    context = canvas.getContext('2d');
    WIDTH = canvas.width;
    HEIGHT = canvas.height;
  }
}