import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> setAccessToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", token);
  }
  
  
  static Future<bool> setId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("id", id);
  }
  static Future<bool> setUserType(String userType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("userType", userType);
  }

  static Future<bool> setLang(String lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("lang", lang);
  }

  static Future<String> getData(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(data) ?? "";
  }

  static Future<bool> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
