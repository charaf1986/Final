import '../../control/BreakoutControl.dart';
import 'dart:html';

BreakoutControl breakGame = new BreakoutControl();
bool startGame=false;

void main() {
  
  breakGame.repeat(0);
  querySelector('#backgroundColor').onBlur.listen(changeBackground);
  querySelector('#ballColor').onBlur.listen(changeBallColor);
  querySelector('#barreColor').onBlur.listen(changeBarreColor);
  querySelector('#ballSpeed').onClick.listen(ballSpeed);
  querySelector('#start').onClick.listen(start);
  querySelector('#pause').onClick.listen(pause);
  querySelector('#new').onClick.listen(newGame);
}

void changeBackground(Event e){
  if (startGame){
    InputElement ie = querySelector('#backgroundColor');
    breakGame.backcolor = ie.value;
  }
}

void changeBallColor(Event e){
  if (startGame){
    InputElement ie = querySelector('#ballColor');
    breakGame.balle.ballcolor = ie.value;
  }
}

void changeBarreColor(Event e){
  if (startGame){
    InputElement ie = querySelector('#barreColor');
    breakGame.barre.paddlecolor = ie.value;
  }
}

void ballSpeed(Event e){
  if (startGame){
    InputElement ie = querySelector('#ballSpeed');
    breakGame.balle.ballr = int.parse(ie.value);
  }
}

void start(Event e){
  int i=1;
  startGame=true;
  breakGame.repeat(i);
}

void pause(Event e){
  if (startGame)
  breakGame.pause();
}

void newGame(Event e){
  breakGame = new BreakoutControl();
  breakGame.repeat(0);
}