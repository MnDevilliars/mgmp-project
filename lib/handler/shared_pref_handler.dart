import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHandler {

  final String sessionToken='';

   void setSessionToken(String sessionToken, String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, sessionToken);
  }

   Future<String> getSessionToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(key);
    return  token ?? "";
  }
}