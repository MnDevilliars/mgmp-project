import 'package:flutter/material.dart';
import './/components/my_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ManagerLoginScreen extends StatelessWidget {
  ManagerLoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // login logic
  Future<bool> login(String email, String pass) async{
    try{
      final response = await http.post(
          Uri.parse('https://rc-mgmp.themeghalayanage.com/api/auth/sign_in'),
          headers: <String, String>{
            'Xen-Origin': 'gAAAAABj4fitdXGtaMIU4-VcP36xx0ylGf8mrUbBA3IV3-x0dbAbhWRVnqWUVIF62YaMar21HM-uEtg_k0cWZ7lsJ-PCpsZTgZiyevE9v95xtUaBtTPOWbc=',
          },
          body: jsonEncode({
            "applicationId": "64cb48d0e78510babebedbc6",
            "method": 2,
            "username": email,
            "password": pass,
          })
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status']) return true;
    } catch(e,s){
      // handle manager failure of login
      print("$e.");
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

  // handle sign in button
  void onSubmitSignIn(BuildContext context) async {
    print("login btn clicked");
    String email = emailController.text;
    String pass = passwordController.text;

    if (email.isEmpty || pass.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill in all fields!"))
      );
      return;
    }

    if (!isValidEmail(email) && !isValidPhoneNumber(email)){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter valid email or phone number!"))
      );
      return;
    }

    bool isAuthenticated = await login(email, pass);

    if (isAuthenticated) {
      context.push("/dashboard");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // logo comes here 3:14
                // SizedBox(height: 50.0),
                Icon(Icons.lock, color: Colors.black87, size: 72.0),

                // welcome back, you've been missed!
                SizedBox(height: 15.0),
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // user email text field
                      SizedBox(width: 400),
                      Textfield(
                        controller: emailController,
                        hintText: 'Enter your email address',
                        obscureText: false,
                        prefixIcon: Icons.email_rounded,
                      ),

                      // password text field
                      SizedBox(height: 20.0),
                      Textfield(
                        controller: passwordController,
                        hintText: 'Enter your password',
                        obscureText: true,
                        prefixIcon: Icons.lock,
                      ),


                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          // Login as Admin
                          GestureDetector(
                            onTap: () {
                              context.push('/admin-login');
                            },
                            child: Text(
                              "Login as Admin",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.deepPurple,
                                fontSize: 16.0,
                              ),
                            ),
                          ),

                          // forget password ?
                          GestureDetector(
                            onTap: () {
                              context.go('/forget-password');
                            },
                            child: Text(
                              "forget password ?",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.deepPurple,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // sign in button
                      SizedBox(height: 45),
                      SizedBox(
                        height: 60.0,
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => onSubmitSignIn(context),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8,
                              ), // Removes rounded corners
                            ),
                          ),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // not a member? register now
                      SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "not a member ? ",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push('/signup');
                            },
                            child: Text(
                              " register now",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.deepPurple,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
