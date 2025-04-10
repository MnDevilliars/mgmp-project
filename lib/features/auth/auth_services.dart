import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../handler/shared_pref_handler.dart';

class AuthServices {

  // logout function
  void logout(BuildContext context, String currentSessionToken) async {
    SharedPrefrenceHandler prefs = SharedPrefrenceHandler();
    prefs.setSessionToken('');
    context.go('/admin-login');
  }

  // login function
  Future<bool> login(String email, String pass) async{
    try{
      final response = await http.post(
          Uri.parse('https://rc-mgmp.themeghalayanage.com/api/auth/sign_in'),
          headers: <String, String>{
            'Xen-Origin': 'gAAAAABj4fitdXGtaMIU4-VcP36xx0ylGf8mrUbBA3IV3-x0dbAbhWRVnqWUVIF62YaMar21HM-uEtg_k0cWZ7lsJ-PCpsZTgZiyevE9v95xtUaBtTPOWbc=',
          },
          body: jsonEncode({
            "applicationId": "63d13582e3890f5f73468476",
            "method": 2,
            "username": email,
            "password": pass,
          })
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status']){
        SharedPrefrenceHandler pref = SharedPrefrenceHandler();
        final currentSessionToken = data['result'][0];
        pref.setSessionToken(currentSessionToken);
        return true;
      }
    } catch(e,s){
      debugPrint("$e, $s");
    }
    return false;
  }

  // email validation
  bool isValidEmail(String input) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    return emailRegex.hasMatch(input);
  }

  // phone number validation
  bool isValidPhoneNumber(String input) {
    try{
      int phone = int.tryParse(input)??0;
      final phoneRegex = RegExp(r'^[0-9]{10}$');
      return phoneRegex.hasMatch(input);
    } catch(e,s){
      print("$e, $s");
      return false;
    }
  }
}