library control;

import 'dart:async';
import '../bin/BD.dart';

class ControlInscription {
  
  BD bd;
  
  ControlInscription(this.bd);
  
  Future<String> addUser(String username, String password, String lastName, String firstName, String email, String country, String province, String city) {
       var completer = new Completer();
       Future<String> future = bd.addUserBd(username,password,lastName,firstName,email,country,province,city);
       future.then((content) {
             if (content.toString() == 'true')
               completer.complete('true');
       });
       return completer.future;
   }
  
  
  Future<String> verifyUsername(String username) {
         var completer = new Completer();
         Future<String> future = bd.verifyUsernameBd(username);
         future.then((content) {
               if (content.toString() == 'existe')
                 completer.complete('existe');
               else
                 completer.complete('nexistepas');
         });
         return completer.future;
     }
  
  Future<String> verifyEmail(String email) {
           var completer = new Completer();
           Future<String> future = bd.verifyEmailBd(email);
           future.then((content) {
                 if (content.toString() == 'existe')
                   completer.complete('existe');
                 else
                   completer.complete('nexistepas');
           });
           return completer.future;
       }

 }