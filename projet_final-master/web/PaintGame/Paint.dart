import '../../control/PaintControl.dart';
import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;

PaintControl paintGame = new PaintControl();
InputElement pic;

void main() {
    
    querySelector('#colorButtonPurple')..onClick.listen(paintGame.toPurple);
    querySelector('#colorButtonGreen')..onClick.listen(paintGame.toGreen);
    querySelector('#colorButtonNoir')..onClick.listen(paintGame.toBlack);
    querySelector('#colorButtonRouge')..onClick.listen(paintGame.toRed);
    querySelector('#colorButtonBleu')..onClick.listen(paintGame.toBlue);
    querySelector('#colorButtonJaune')..onClick.listen(paintGame.toYellow);
    querySelector('#sizeButtonSmall')..onClick.listen(paintGame.toSmall);
    querySelector('#sizeButtonMedium')..onClick.listen(paintGame.toMedium);
    querySelector('#sizeButtonBig')..onClick.listen(paintGame.toBig);
    querySelector('#toolButtonCrayon')..onClick.listen(paintGame.toCrayon);
    querySelector('#toolButtonMarker')..onClick.listen(paintGame.toMarker);
    querySelector('#toolButtonEraser')..onClick.listen(paintGame.toEraser);
    querySelector('#menuNew')..onClick.listen(newPaint);
    querySelector('#menuSave')..onClick.listen(savePaint);
    pic = querySelector('#pic');
    pic..onChange.listen(filesInputHandler);
    querySelector('#buttonSaveDraw')..onClick.listen(saveDrawServer);
}

void newPaint(Event e){
  paintGame.menuNew();
}

void savePaint(Event e){
  InputElement ie = querySelector('#titleDraw');
  ie.value="";
  paintGame.savePaint();
}

void filesInputHandler(Event e){
  paintGame.loadImage("../images/"+pic.files[0].name);
}

void saveDrawServer(Event e){
  InputElement ie = querySelector('#titleDraw');
  
  HttpRequest.request("http://localhost:8888/submit",
            method: "post",
            sendData: "saveDraw:"+ie.value+"!"+cookie.get('username'))
          .then((HttpRequest req) {
           
            if (req.responseText == 'draw saved')
            {
              window.alert("Draw saved");
            }
              
          })
          .catchError((e) => print(e));
  
  
}