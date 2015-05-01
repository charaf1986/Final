import 'package:sqljocky/sqljocky.dart';
import 'package:sqljocky/utils.dart';
import 'package:options_file/options_file.dart';
import 'dart:async';

class BD {
  ConnectionPool pool;
  
  BD(String file) {
    
    OptionsFile options = new OptionsFile(file);
    String user = options.getString('user');
    String password = options.getString('password');
    int port = options.getInt('port', 3306);
    String db = options.getString('db');
    String host = options.getString('host', 'localhost');

    // create a connection
    print("opening connection");
    pool = new ConnectionPool(host: host, port: port, user: user, password: password, db: db, max:1);
 
    print("connection open");
    print("Running bd");
  }
  
  Future<String> verifyCredentials(String username, String password) {
    var completer = new Completer();
    Future<Results> result = pool.query('select count(*) '
        'from projet.users p where p.username="$username" and p.password="$password" ').then((result) {

      result.forEach((row) {
       
        if (row[0] >= 1){
            completer.complete('true');
          }
        else
          completer.complete('false');
          
      });       
    });

    return completer.future;
  }
  
  
  Future<String> addUserBd(String username, String password, String lastName, String firstName, String email, String country, String province, String city) {
    var completer = new Completer();
    var querier = new QueryRunner(pool, 
          ['insert into users '
           '(username,password,nom,prenom,courriel,ville,province,pays)'
           'values ("$username","$password","$lastName","$firstName"'
           ',"$email","$city","$province","$country")']);
     
      completer.complete('true');
      querier.executeQueries();
      return completer.future;
    }
  
  
  Future<String> verifyUsernameBd(String username) {
      var completer = new Completer();
      Future<Results> result = pool.query('select count(*) '
          'from projet.users p where p.username="$username"').then((result) {
        print("got results");
        
        result.forEach((row) {
         
          if (row[0] >= 1){
              completer.complete('existe');
            }
          else
            completer.complete('nexistepas');
            
        });       
  });

      return completer.future;
    }
  
  
  Future<String> verifyEmailBd(String email) {
        var completer = new Completer();
        Future<Results> result = pool.query('select count(*) '
            'from projet.users p where p.courriel="$email"').then((result) {
          print("got results");
          
          result.forEach((row) {
           
            if (row[0] >= 1){
                completer.complete('existe');
              }
            else
              completer.complete('nexistepas');
              
          });       
    });

        return completer.future;
      }
  
  Future<String> saveDrawBd(String titleUser) {
    var completer = new Completer();
    List<String> spl = titleUser.split("!");
    String username=spl[1];
    String title=spl[0];
    String path="images/"+title+".png";
    DateTime dt = new DateTime.now();
    String heureDate = dt.toString();

    var querier = new QueryRunner(pool, 
              ['insert into dessins '
               '(title,path,heureDate,nbVotes,idUser)'
               'values ("$title","$path","$dt","0"'
               ',(select p.idUser from projet.users p where p.username="$username"))']);

      completer.complete('true');
      querier.executeQueries();
      return completer.future;
    }
  
  Future<int> bestDrawsBdLen() {
         var completer = new Completer();
         Future<Results> result = pool.query('select count(*) '
          'from projet.dessins, projet.users '
          'where users.idUser = dessins.idUser order by nbVotes DESC;').then((result) {
            result.forEach((row) {
              completer.complete(row[0]);               
           });       
      });
         return completer.future;
   }
  
  Future<String> bestDrawsBd() {
      var completer = new Completer();
      Future<int> future = bestDrawsBdLen();

      future.then((content) {
        
          List<String> list = new List<String>();
          int i=0;
          Future<Results> result = pool.query('select dessins.title,dessins.path,'
              'dessins.heureDate,dessins.nbVotes,users.prenom,users.nom,dessins.idDessin '
              'from projet.dessins, projet.users '
              'where users.idUser = dessins.idUser order by nbVotes DESC;').then((res) {
 
            res.forEach((row) {
              list.add("${row[0]},${row[1]},${row[2]},${row[3]},${row[4]},${row[5]},${row[6]}!");
              i++;
                if (i == content) 
                  completer.complete(list.toString());
            });
          });
       });
      return completer.future;
      
  }
  
  Future<String> voteBd(String idDessin) {
     var completer = new Completer();
     var querier = new QueryRunner(pool, 
           ['update dessins '
            'set nbVotes=nbVotes+1 '
            'where idDessin="$idDessin"']);
      
       completer.complete('true');
       querier.executeQueries();
       return completer.future;
     }

}

