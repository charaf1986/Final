library control;

import 'dart:async';
import '../bin/BD.dart';

class ControlVote {
  
  BD bd;
  
  ControlVote(this.bd);
  
  Future<String> vote(String idDessin) {
         var completer = new Completer();
         Future<String> future = bd.voteBd(idDessin);
         future.then((content) {
                 completer.complete('true');
         });
         return completer.future;
     }

 }