import 'package:polymer/polymer.dart';
import '../bin/Connexion.dart';
import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;

@CustomTag('connexion-form')
class ConnexionForm extends PolymerElement {
  final Connexion connexion = new Connexion();

  
  ConnexionForm.created() : super.created(){
    if (cookie.get('connSession') == "valid")
        window.location.replace('games.html');
  }

  @published String action;

  doSubmit(Event e, var detail, Node target) {
    e.preventDefault();

    FormElement form = target as FormElement;
    form.action = action;
    

    HttpRequest.request(action,
          method: form.method,
          sendData: new FormData(form))
        .then((HttpRequest req) {
          
          if (req.responseText == 'non')
            shadowRoot.querySelector('#message').text = req.responseText;
          else { 
            cookie.set('connSession', 'valid', path: '/');
            cookie.set('username', req.responseText);
            window.location.replace('games.html');
          }
          
            
        })
        .catchError((e) => print(e));

  }
}