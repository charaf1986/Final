import 'dart:io';
import 'dart:async';
import 'package:http_server/http_server.dart';
import 'BD.dart';
import '../control/ControlConnexion.dart';
import '../control/ControlInscription.dart';
import '../control/ControlSaveDraw.dart';
import '../control/ControlBestDraws.dart';
import '../control/ControlVote.dart';

main() {
  HttpServer.bind('0.0.0.0', 8888).then((HttpServer server) {
    print('Server is running');
    BD bd = new BD('files/connection.options');
    server.listen((HttpRequest req) {
      if (req.uri.path == '/submit' && req.method == 'POST') {
        echo(bd,req);
      }
    });
  });
}

echo(BD bd, HttpRequest req) {
  print('received submit');
  HttpBodyHandler.processRequest(req).then((HttpBody body) {
    print(body.body.runtimeType); // Map
      List<String> cleanedStr = cleanReq(body.body.toString());
          
      if (cleanedStr[cleanedStr.length-1].contains("connexionButton")){
        ControlConnexion cc = new ControlConnexion(bd);
        Future<String> future = cc.controlConnex(getData(cleanedStr[0]),getData(cleanedStr[1]));
        future.then((content) {
          if (content=='true') {
            sendResponse(req,getData(cleanedStr[0]));
          }
          else
            sendResponse(req,'non');
        });
       }
      else if (cleanedStr[cleanedStr.length-1].contains("inscriptionButton"))
      {
              ControlInscription cc = new ControlInscription(bd);
              Future<String> future = cc.addUser(getData(cleanedStr[0]),getData(cleanedStr[1]),getData(cleanedStr[2]),getData(cleanedStr[3]),
                  getData(cleanedStr[4]),getData(cleanedStr[5]),
                  getData(cleanedStr[6]),getData(cleanedStr[7]));
                      future.then((content) {
                        if (content=='true') {
                          sendResponse(req,'added');
                        }
                      });
      }
      else if(cleanedStr[cleanedStr.length-1].contains("verifyUser")){
        ControlInscription cc = new ControlInscription(bd);
        Future<String> future = cc.verifyUsername(getData(body.body.toString()));
                              future.then((content) {
                                if (content=='existe') {
                                  sendResponse(req,'existe');
                                }
                              });
      }
      else if(cleanedStr[cleanedStr.length-1].contains("verifyEmail")){
              ControlInscription cc = new ControlInscription(bd);
              Future<String> future = cc.verifyEmail(getData(body.body.toString()));
                                    future.then((content) {
                                      if (content=='existe') {
                                        sendResponse(req,'existe');
                                      }
                                    });
            }
      else if(cleanedStr[cleanedStr.length-1].contains("saveDraw")){
                    ControlSaveDraw cc = new ControlSaveDraw(bd);
                    Future<String> future = cc.saveDraw(getData(body.body.toString()));
                    future.then((content) {
                          if (content=='true') {
                            sendResponse(req,'draw saved');
                          }
                   });
                  }
      else if(cleanedStr[cleanedStr.length-1].contains("bestDraws")){
             ControlBestDraws cc = new ControlBestDraws(bd);
             Future<String> future = cc.bestDraws();
             future.then((content) {
               sendResponse(req,content);
                         });
                        }
      else if(cleanedStr[cleanedStr.length-1].contains("up")){
                   ControlVote cc = new ControlVote(bd);
                   Future<String> future = cc.vote(getIdDessin(getData(body.body.toString())));
                   future.then((content) {
                     sendResponse(req,'voted');
                                      
                               });
                              }
      else
        print('non');

  });
}

List<String> cleanReq(String req){
  String abc = req.replaceAll('{','');
  String newStr = abc.replaceAll('}','');
  List<String> spl = newStr.split(",");
  return spl;
}

String getData(String x){
  List<String> spl = x.split(":");
  return spl[1].trim();
}

String getIdDessin(String x){
  List<String> spl = x.split("Vote");
    return spl[1].trim();
}

void sendResponse(HttpRequest req, String content){
  req.response
    ..headers.add('Access-Control-Allow-Origin', '*')
      ..headers.add('Content-Type', 'text/plain')
        ..statusCode = 201
          ..write(content)
            ..close();
}