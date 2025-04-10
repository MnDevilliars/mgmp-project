import 'package:flutter/material.dart';
import 'package:flutterxlayer01/features/auth/admin_login_screen.dart';
import 'package:flutterxlayer01/features/auth/manager_login_screen.dart';
import 'package:flutterxlayer01/features/auth/signup_screen.dart';
import 'package:flutterxlayer01/features/pages/artists.dart';
import 'package:flutterxlayer01/core/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String session = prefs.getString('sessionToken') ?? "";
  runApp(MyApp(session: session));
}

class MyApp extends StatelessWidget {
  final String session;
  const MyApp({super.key, required  this.session});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter(session: session).router,
    );
  }
}