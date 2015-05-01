import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;

void main(){
  
  try {
    if (!cookie.get('connSession').contains("valid"))
          window.location.replace('projet.html');
  } catch(exception) {
    window.location.replace('projet.html');
  }
  
  querySelector('#username').text = cookie.get('username');
  querySelector('#imgBreakout').onClick.listen(onClickBreakout);
  querySelector('#imgPaint').onClick.listen(onClickPaint);
  querySelector('#buttBestDraws').onClick.listen(toBestDraws);
  querySelector('#labLogout').onClick.listen(toLogout);
}

void onClickBreakout(Event e){
  window.location.assign('BreakoutGame/Breakout.html');
}

void onClickPaint(Event e){
  window.location.assign('PaintGame/Paint.html');
}

void toBestDraws(Event e){
  window.location.assign('BestDraws.html');
}

void toLogout(Event e){
  cookie.remove('connSession', path: '/');
  cookie.remove('username');
  window.location.replace('projet.html');
}