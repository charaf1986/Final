library control;

import 'dart:async';
import '../bin/BD.dart';

class ControlConnexion {
  
  BD bd;
  
  ControlConnexion(this.bd);

  Future<String> controlConnex(String username, String password) {
    var completer = new Completer();
    Future<String> future = bd.verifyCredentials(username,password);
    future.then((content) {
      if (content.toString() == 'true')
        completer.complete('true');
      else
        completer.complete('false');
    });
    return completer.future;
  }

}