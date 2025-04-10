import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHandler {

  void setSessionToken(String sessionToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("sessionToken", sessionToken);
  }

  Future<String> getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("sessionToken");
    return token ?? "";
  }
}