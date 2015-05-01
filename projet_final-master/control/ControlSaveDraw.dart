library control;

import 'dart:async';
import '../bin/BD.dart';

class ControlSaveDraw {
  
  BD bd;
  
  ControlSaveDraw(this.bd);
  
  Future<String> saveDraw(String titleUser) {
         var completer = new Completer();
         Future<String> future = bd.saveDrawBd(titleUser);
         future.then((content) {
               if (content.toString() == 'true')
                 completer.complete('true');
         });
         return completer.future;
     }

 }