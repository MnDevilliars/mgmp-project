import 'package:flutter/material.dart';
import './/components/my_textfield.dart';
import 'package:go_router/go_router.dart';
import './auth_services.dart';


class ManagerLoginScreen extends StatelessWidget {
  ManagerLoginScreen({super.key});
  final AuthServices authServices = AuthServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  // handle sign in button
  void handleSubmitSignIn(BuildContext context) async {

    String email = emailController.text;
    String pass = passwordController.text;

    if (email.isEmpty || pass.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill in all fields!"))
      );
      return;
    }

    if (!authServices.isValidEmail(email) && !authServices.isValidPhoneNumber(email)){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter valid email or phone number!"))
      );
      return;
    }

    bool isAuthenticated = await authServices.login(email, pass);

    if (!isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
      return;
    }

    context.push("/dashboard");

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, color: Colors.black87, size: 54.0),
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("Manager Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
                      ],
                    ),
                  ],
                ),

                // welcome back, you've been missed!
                SizedBox(height: 20.0),
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
                          onPressed: () => handleSubmitSignIn(context),
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
