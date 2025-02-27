import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String id = "";
  String token = "";
  String email = "";
  String name = "";
  String lastName = "";

  Future<void> loadUser() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userData = sharedPreferences.getStringList("user");

    if (userData != null) {
      id = userData[0];
      token = userData[1];
      email = userData[2];
      name = userData[3];
      lastName = userData[4];
      notifyListeners();
    }
  }

  Future<void> saveUser(String id, String token, String email, String name, String lastName) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setStringList("user", [id, token, email, name, lastName]);

    this.id = id;
    this.token = token;
    this.email = email;
    this.name = name;
    this.lastName = lastName;
    notifyListeners();
  }
}