library control;

import 'dart:html';

class PaintControl{
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  int WIDTH;
  int HEIGHT;
  var paint=false;
  var clickX = new List();
  var clickY = new List();
  var clickDrag = new List();
  var colorPurple = "#cb3594";
  var colorGreen = "#659b41";
  var colorYellow = "#ffcf33";
  var colorBlack = "#000000";
  var colorBlue = "#0000FF";
  var colorRed = "#FF0000";
  

  var curColor;
  var clickColor;
  
  
  var clickSize = new List();
  var curSize = 5;
  
  var clickTool = new List();
  var curTool = "marker";
  
  
  ImageElement image = new ImageElement(src: "../images/watermelon-duck.png");
  
  PaintControl(){
    canvas = document.querySelector('#canvasPaint');
    context = canvas.getContext('2d');
    
    WIDTH = canvas.width;
    HEIGHT = canvas.height;
    curColor = colorBlack;
    clickColor = new List();
    window.onMouseDown.listen(onMouseDown);
    window.onMouseMove.listen(onMouseMove);
    window.onMouseUp.listen(onMouseUp);
    window.onMouseLeave.listen(onMouseLeave);
    
    querySelector('#sizeButtonSmall')..onClick.listen(toSmall);
    querySelector('#sizeButtonBig')..onClick.listen(toBig);
    
    querySelector('#toolButtonCrayon')..onClick.listen(toCrayon);
    querySelector('#toolButtonMarker')..onClick.listen(toMarker);
    querySelector('#toolButtonEraser')..onClick.listen(toEraser);
   
    image.onLoad.listen((e) {
      context.drawImage(image, 120, 100);
    });
  }
  
  void onMouseDown(MouseEvent e) {    
    paint = true;
    addClick(e.page.x - canvas.offset.left, e.page.y - canvas.offset.top,false);
    redraw();
  }
  
  void onMouseMove(MouseEvent e) {
    if(paint){
      addClick(e.page.x - canvas.offset.left, e.page.y - canvas.offset.top, true);
      redraw();
    }
  }
  
  void onMouseUp(MouseEvent e) {
    paint=false;
    removeLists();
  }
  
  void onMouseLeave(MouseEvent e) {
    paint=false;
    removeLists();
  }
  
  void removeLists(){
    clickX.removeRange(0,clickX.length);
    clickY.removeRange(0,clickY.length);
    clickDrag.removeRange(0,clickDrag.length);
    clickColor.removeRange(0,clickColor.length);
    clickSize.removeRange(0,clickSize.length);
  }
  
  void toPurple(Event event) {
    curColor = colorPurple;
  }
  
  void toGreen(Event event) {
    curColor = colorGreen;
  }
  
  void toBlack(Event event) {
     curColor = colorBlack;
   }
  
  void toRed(Event event) {
     curColor = colorRed;
   }
  
  void toBlue(Event event) {
     curColor = colorBlue;
   }
  
  void toYellow(Event event) {
     curColor = colorYellow;
   }
  
  void toSmall(Event event) {
    curSize = 1;
  }
  
  void toMedium(Event event) {
      curSize = 5;
    }
  
  void toBig(Event event) {
    curSize = 10;
  }
  
  void toCrayon(Event event) {
    curTool = "crayon";
  }
  
  void toMarker(Event event) {
    curTool = "marker";
  }
  
  void toEraser(Event event) {
    curTool = "eraser";
  }
  
  void menuNew(){
    context.globalAlpha = 1;
    context.clearRect(0, 0, WIDTH, HEIGHT);
    context.drawImage(image, 120, 100);
    curColor = colorBlack;
    curSize = 5;
    curTool = "marker";
  }
  
  void savePaint(){
    var dataURL = canvas.toDataUrl();

    ImageElement im = querySelector('#canvasImg');
    im.src = dataURL;
  }
  
  void loadImage(String imagePath){
    ImageElement im = new ImageElement(src: imagePath);

    context.globalAlpha = 1;
    context.clearRect(0, 0, WIDTH, HEIGHT);
    im.onLoad.listen((e) {
      context.drawImage(im, 0, 0);
        });
  }
  
  void addClick(x, y, dragging)
  {
    clickX.add(x);
    clickY.add(y);
    clickDrag.add(dragging);
    if(curTool == "eraser")
      clickColor.add("white");
    else
      clickColor.add(curColor);
    clickSize.add(curSize);
  }
  
  void redraw(){
    context.lineJoin = "round";
    
    context.save();
    context.beginPath();
    context.rect(0, 0, WIDTH, HEIGHT);
    context.clip();
    
    for(var i=0; i < clickX.length; i++) {    
      context.beginPath();
      if(clickDrag[i] && i>0)
        context.moveTo(clickX[i-1], clickY[i-1]);
      else
        context.moveTo(clickX[i]-1, clickY[i]);
      
      context.lineTo(clickX[i], clickY[i]);
      context.closePath();
      context.strokeStyle = clickColor[i];
      context.lineWidth = curSize;
      context.stroke();
    }
    context.restore();
    
    if(curTool == "crayon")
      context.globalAlpha = 0.1;
    else if (curTool == "marker")
    context.globalAlpha = 1;
  }
}