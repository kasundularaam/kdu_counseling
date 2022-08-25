import 'package:shared_preferences/shared_preferences.dart';

import '../models/shared_user.dart';

class SharedServices {
  static const String idKey = "id";
  static const String emailKey = "email";
  static const String passwordKey = "password";

  static Future<int> getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final int id = preferences.getInt(idKey) ?? -1;
    return id;
  }

  static Future addUser({required SharedUser user}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(idKey, user.id);
    preferences.setString(passwordKey, user.password);
    preferences.setString(emailKey, user.email);
  }

  static Future<SharedUser> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final int id = preferences.getInt(idKey) ?? -1;
    final String email = preferences.getString(emailKey) ?? "";
    final String password = preferences.getString(passwordKey) ?? "";
    return SharedUser(id: id, email: email, password: password);
  }

  static Future removeUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(idKey);
    preferences.remove(passwordKey);
    preferences.remove(emailKey);
  }

  static Future<bool> isUserIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final int id = preferences.getInt(idKey) ?? -1;
    return id != -1;
  }
}
