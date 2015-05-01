import 'dart:html';
import 'package:cookie/cookie.dart' as cookie;

List<String> listButtons = new List<String>();
List<String> listImgs = new List<String>();

void main(){
 /* try {
      if (!cookie.get('connSession').contains("valid"))
            window.location.replace('projet.html');
    } catch(exception) {
      window.location.replace('projet.html');
    }
    */
  HttpRequest.request("http://localhost:8888/submit",
            method: "POST",
            sendData: "bestDraws")
          .then((HttpRequest req) {
    
           drawTable(req.responseText);

           for(int i=0;i<listButtons.length;i++)
              querySelector(listButtons[i]).onClick.listen((MouseEvent e) => onVote(e,i));

           for(int i=0;i<listImgs.length;i++)
              querySelector(listImgs[i]).onClick.listen((MouseEvent e) => onZoom(e,i));
              
          })
          .catchError((e) => print(e));

}

void drawTable(String list){
  
  List<String> lDiv = divList(list);
  
  StringBuffer sb = new StringBuffer("");

  sb.write("<table>");
  sb.write("<tr>");
  sb.write("<th>Image</th>");sb.write("<th>Données</th>"); 
  sb.write("</tr>");
  
  for(int i=0; i<lDiv.length;i++){
    List<String> lData = getData(lDiv[i]);
    if (i>=1)
      lData.removeAt(0);
    
      sb.write("<tr>");
      // image
        sb.write("<th>"); 
        sb.write("<div class=container>"); 
          sb.write("<a href=#modal class=btn go>");
            sb.write("<img id=img"+i.toString()+" src='"+lData[1]+"' width='250' height='200'/>");
          sb.write("</a>");
          listImgs.add("#img"+i.toString());
          sb.write("</div>"); 
        sb.write("</th>");
        
      // données
        sb.write("<th>");
          sb.write("Title : <label>"+lData[0]+"</label><br>");
          sb.write("Date/Hour : <label>"+lData[2]+"</label><br>");
          sb.write("Creator : <label>"+lData[4]+" "+lData[5]+"</label><br>");
          sb.write("Votes : <label>"+lData[3]+"</label><br>");
          sb.write("<input id=buttonVote"+lData[6]+" name="+lData[6]+" type=button value=Vote />");
          listButtons.add("#buttonVote"+lData[6]);
        sb.write("</th>");
        
        if (i<=2) {
        sb.write("<th>");
                  sb.write("<img src='images/"+(i+1).toString()+".jpg' width='120' height='100'/>");
        sb.write("</th>");
        }
        
        sb.write("</tr>");
  }
  sb.write("</table>");
  
  sb.write("<div id=modal>");
  sb.write("<div class=modal-content>");
        
        sb.write("<div class=copy>");
          sb.write("<img id=canvasImg>");
        sb.write("</div>"); 
        
        sb.write("<div class=cf footer>");
          sb.write("<a href=# class=btn>Close</a>");
        sb.write("</div>");

  sb.write("</div>"); 
  sb.write("</div>"); 
  querySelector('#bestDraws').setInnerHtml(sb.toString());
}

List<String> divList(String list){
  String abc = list.replaceAll('[','');
  String newStr = abc.replaceAll(']','');
  List<String> spl = newStr.split("!");  
  spl.removeAt(spl.length-1);

  return spl;
}

List<String> getData(String x){
  List<String> spl = x.split(",");
  return spl;
}

void onVote(Event e, var i){
  String idButtVote = listButtons[i];
  
  HttpRequest.request("http://localhost:8888/submit",
               method: "POST",
               sendData: "up:"+idButtVote)
             .then((HttpRequest req) {
              
              if (req.responseText == 'voted')
              {
                InputElement ie = querySelector(idButtVote);
                ie.disabled = true;
                window.alert("Done");
              }
             })
             .catchError((e) => print(e));
}

void onZoom(Event e, var i){
  ImageElement im = querySelector(listImgs[i]);
  ImageElement imZ = querySelector('#canvasImg');
  imZ.src = im.src;
}
