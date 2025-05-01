import 'package:flutter/material.dart';
import '../../components/my_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../handler/shared_pref_handler.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final bankNameController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final bankAccountNumberController = TextEditingController();

  final String backgroundImage = 'assets/images/mgmp-background.jpg';

  Future<bool> signup(
    String firstName,
    String middleName,
    String lastName,
    String email,
    String phone,
    String pass,
    String bankName,
    String ifscCode,
    String accountNumber,
  ) async {
    try {
      print("********************************************************");
      print("$firstName  $middleName  $lastName  $phone  $email  $pass  $ifscCode  $accountNumber  $bankName");
      print("********************************************************");
      final response = await http.post(
        Uri.parse('https://rc-mgmp.themeghalayanage.com/api/auth/sign_up'),
        headers: <String, String>{
          'Xen-Origin':
              'gAAAAABj4fitdXGtaMIU4-VcP36xx0ylGf8mrUbBA3IV3-x0dbAbhWRVnqWUVIF62YaMar21HM-uEtg_k0cWZ7lsJ-PCpsZTgZiyevE9v95xtUaBtTPOWbc=',
        },
        body: jsonEncode({
          "applicationId": "64cb48d0e78510babebedbc6",
          "method": 2,
          "firstName": firstName,
          "middleName": middleName,
          "lastName": lastName,
          "phoneNumber": int.parse(phone),
          "email": email,
          "dialCode": 91,
          "password": pass.toString(),
          "ifscCode": ifscCode,
          "accountNumber": int.parse(accountNumber),
          "bankName": bankName,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status']){
        SharedPrefrenceHandler pref = SharedPrefrenceHandler();
        final currentSessionToken = data['result'][0];
        print(currentSessionToken);
        pref.setSessionToken(currentSessionToken);
        print('account created successfully');
        print('current session token: $currentSessionToken');
        return true;
      }
    } catch (e, s) {
      debugPrint("$e, $s");
    }
    return false;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhoneNumber(String phone) {
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    return mobileRegex.hasMatch(phone);
  }

  bool isValidIFSC(String ifsc) {
    final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    return ifscRegex.hasMatch(ifsc);
  }

  Future<void> onSubmitSignUp() async {
    print("submit clicked");
    String firstName = firstNameController.text;
    String middleName = middleNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String phone = phoneNumberController.text;
    String pass = passwordController.text;
    String bankName = bankNameController.text;
    String ifscCode = ifscCodeController.text;
    String accountNumber = bankAccountNumberController.text;

    if (firstName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        pass.isEmpty ||
        bankName.isEmpty ||
        ifscCode.isEmpty ||
        accountNumber.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill in all fields!")));
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter valid email!")));
      return;
    }

    if (!isValidPhoneNumber(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid phone number!")),
      );
      return;
    }

    if (!isValidIFSC(ifscCode)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter valid IFSC Code!")));
      return;
    }

    bool isAuthenticated = await signup(
      firstName,
      middleName,
      lastName,
      email,
      phone,
      pass,
      bankName,
      ifscCode,
      accountNumber,
    );

    if (isAuthenticated) {
      print("Account created successfully!");
      context.push("/admin-login");
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid signup credentials')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(backgroundImage, fit: BoxFit.cover),
            ),

            // Positioned.fill(
            //   child: Container(color: Colors.green.withOpacity(0.2)),
            // ),

            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            color: Colors.white,
                            size: 72.0,
                            shadows: [
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 4.0,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          Text(
                            "Sign Up",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ? ",
                            textAlign: TextAlign.right,
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
                          GestureDetector(
                            onTap: () {
                              context.push('/manager-login');
                            },
                            child: Text(
                              " Sign In",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF9ACD32),
                                fontSize: 18.0,
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
                      SizedBox(height: 20),
                      TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'First name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.green.shade700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: middleNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'Middle name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.text_fields,
                            color: Colors.green.shade700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'Last name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.text_fields,
                            color: Colors.green.shade700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'Email',
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
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'Phone number',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.green.shade700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.password,
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
                      SizedBox(height: 15),
                      TextField(
                        controller: bankNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'Bank name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.account_balance,
                            color: Colors.green.shade700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: ifscCodeController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'IFSC code',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: Colors.green.shade700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        obscureText: false,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: bankAccountNumberController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: 'Account number',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.numbers,
                            color: Colors.green.shade700,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        obscureText: false,
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
                            onPressed: onSubmitSignUp,
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              elevation: 50,
                            ),
                            child: Text(
                              "Create your free account",
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
