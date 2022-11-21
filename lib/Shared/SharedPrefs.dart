import 'package:shared_preferences/shared_preferences.dart';

setLogin(String login) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('login', login);
}
removeLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('login');
}

setName(String name) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', name);
}
removeName() async  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('login');
}

setEmail(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
}
removeEmail()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('email');
}

setJwt(String jwt) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('jwt', jwt);
}
removeJwt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('jwt');
}
