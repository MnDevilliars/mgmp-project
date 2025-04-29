import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'auth_services.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final AuthServices authServices = AuthServices();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailErrorText;
  String? passwordErrorText;


  final String backgroundImage = 'assets/login_bgImages/mgmploginbg01.jpg';

  void handleSubmitSignIn(BuildContext context) async {
    String email = emailController.text.trim();
    String pass = passwordController.text.trim();

    setState(() {
      emailErrorText = null;
      passwordErrorText = null;
    });

    bool hasError = false;

    if (email.isEmpty) {
      setState(() {
        emailErrorText = '*Please enter your email or phone number';
      });
      hasError = true;
      return;
    } else if (!authServices.isValidEmail(email) &&
        !authServices.isValidPhoneNumber(email)) {
      setState(() {
        emailErrorText = '*Invalid email or phone number';
      });
      hasError = true;
      return;
    }

    if (pass.isEmpty) {
      setState(() {
        passwordErrorText = 'Please enter your password';
      });
      hasError = true;
    }

    if (hasError) return;

    if (!authServices.isValidEmail(email) &&
        !authServices.isValidPhoneNumber(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email or phone number!")),
      );
      return;
    }

    final loginData = await authServices.login(email, pass);

    if (!loginData) {
      setState(() {
        emailErrorText = 'Invalid Email or phone number!';
        passwordErrorText = 'Invalid password!';
      });
      return;
    }

    context.go("/dashboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Stack(
          children: [
            // Single static background image
            Positioned.fill(
              child: Image.asset(backgroundImage, fit: BoxFit.cover),
            ),

            // Dark overlay
            Positioned.fill(
              child: Container(color: Colors.green.withOpacity(0.2)),
            ),

            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 60.0,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 4.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          children: [
                            Text(
                              "Admin Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2.0, 2.0),
                                    blurRadius: 4.0,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Welcome back, you've been missed!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 4.0,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Email field
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              errorText: emailErrorText,
                              errorStyle: TextStyle(color: Colors.white),
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.green.shade700,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),

                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              errorText: passwordErrorText,
                              errorStyle: TextStyle(color: Colors.white),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.green.shade700,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                            obscureText: true,
                          ),

                          SizedBox(height: 12),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.push('/manager-login');
                                  },
                                  child: Text(
                                    "Login as Manager",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF9ACD32),
                                      fontSize: 16.0,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 4.0,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.push('/forget-password');
                                  },
                                  child: Text(
                                    "Forget password?",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF9ACD32),
                                      fontSize: 16.0,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 4.0,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 45),

                          SizedBox(
                            height: 60.0,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xFF6B8E23), Color(0xFF9ACD32)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(0, 4),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () => handleSubmitSignIn(context),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                ),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 4.0,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                          SizedBox(height: 45),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
