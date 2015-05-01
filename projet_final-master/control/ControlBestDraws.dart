library control;

import 'dart:async';
import '../bin/BD.dart';

class ControlBestDraws {
  
  BD bd;
  
  ControlBestDraws(this.bd);
  
  Future<String> bestDraws() {
         var completer = new Completer();
         Future<String> future = bd.bestDrawsBd();
         future.then((content) {
                 completer.complete(content.toString());
         });
         return completer.future;
     }

 }