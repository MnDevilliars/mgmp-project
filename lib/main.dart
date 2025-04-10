import 'package:flutter/material.dart';
import 'package:flutterxlayer01/features/auth/admin_login_screen.dart';
import 'package:flutterxlayer01/features/auth/manager_login_screen.dart';
import 'package:flutterxlayer01/features/auth/signup_screen.dart';
import 'package:flutterxlayer01/features/pages/artists.dart';
import 'package:flutterxlayer01/core/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../handler/shared_pref_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefrenceHandler pref = SharedPrefrenceHandler();
  String sessionToken = await pref.getSessionToken();
  runApp(MyApp(sessionToken: sessionToken.isEmpty ? "" : sessionToken));
}

class MyApp extends StatelessWidget {
  final String sessionToken;
  const MyApp({super.key, required  this.sessionToken});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter(sessionToken: sessionToken).router,
    );
  }
}