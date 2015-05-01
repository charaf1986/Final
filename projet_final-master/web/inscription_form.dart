import 'package:polymer/polymer.dart';
import '../bin/Inscription.dart';
import 'dart:html';
import 'dart:convert';

@CustomTag('inscription-form')
class InscriptionForm extends PolymerElement {
  final Inscription ins = new Inscription();
  var urlPays = "http://127.0.0.1:3030/Projet/bin/files/Pays.json";
  var urlProvincesCA = "http://127.0.0.1:3030/Projet/bin/files/ProvincesCA.json";
  
  InscriptionForm.created() : super.created(){

    var requestPays = HttpRequest.getString(urlPays).then(loadPays);

    shadowRoot.querySelector('#textCountry')..onBlur.listen(loadProvinces);
    shadowRoot.querySelector('#user')..onBlur.listen(verifyUsername);
    shadowRoot.querySelector('#email')..onBlur.listen(verifyEmail);
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

          if (req.responseText == 'added')
          {
            window.alert("User added");
            window.location.replace('projet.html');
          }
            
        })
        .catchError((e) => print(e));

  }
  
  void loadPays(String responseText) {
      Map parsedMap = JSON.decode(responseText);

      StringBuffer sb = new StringBuffer("<datalist id='countries'>");
      
      List valuesCountry = parsedMap.values.toList();
      List keysCountry = parsedMap.keys.toList();
      for(int i=0; i<valuesCountry.length; i++)
           sb.write("<option value='"+valuesCountry[i]+"'>");
          
      sb.write("</datalist>");
      
      shadowRoot.querySelector('#listCountries').setInnerHtml(sb.toString());
  }
  
  void loadProvinces(Event e) {  
    shadowRoot.querySelector('#listProvinces').setInnerHtml("");
    InputElement country = shadowRoot.querySelector('#textCountry');
    if (country.value == "Canada")
      var requestProvinces = HttpRequest.getString(urlProvincesCA).then(loadProv);

  }
  
  void loadProv(String responseText){
    Map parsedMap = JSON.decode(responseText);

          StringBuffer sb = new StringBuffer("<datalist id='provinces'>");
          
          List valuesProv = parsedMap.values.toList();
          for(int i=0; i<valuesProv.length; i++)
               sb.write("<option value='"+valuesProv[i]+"'>");
              
          sb.write("</datalist>");
          
          shadowRoot.querySelector('#listProvinces').setInnerHtml(sb.toString());
  }
  
  void verifyUsername(Event e) {
    shadowRoot.querySelector('#verifyUsername').text = '';
    InputElement ie = shadowRoot.querySelector('#user');
    HttpRequest.request(action,
              method: "post",
              sendData: "verifyUser:"+ie.value)
            .then((HttpRequest req) {
              
              if (req.responseText == 'existe')
              {
                shadowRoot.querySelector('#verifyUsername').text = 'Username exists';
                ie.value="";
              }
                
            })
            .catchError((e) => print(e));
    }
  
  void verifyEmail(Event e) {
      shadowRoot.querySelector('#verifyEmail').text = '';
      InputElement ie = shadowRoot.querySelector('#email');
      HttpRequest.request(action,
                method: "post",
                sendData: "verifyEmail:"+ie.value)
              .then((HttpRequest req) {
                
                if (req.responseText == 'existe')
                {
                  shadowRoot.querySelector('#verifyEmail').text = 'Email exists';
                  ie.value="";
                }
                  
              })
              .catchError((e) => print(e));
      }
}