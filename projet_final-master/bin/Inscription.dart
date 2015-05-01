import 'package:polymer/polymer.dart';

class Inscription extends Object with Observable {
  @observable String username;
  @observable String password;
  @observable String lastName;
  @observable String firstName;
  @observable String email;
  @observable String city;
  @observable String province;
  @observable String country;
}