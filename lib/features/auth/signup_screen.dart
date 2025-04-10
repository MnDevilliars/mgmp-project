import 'package:flutter/material.dart';
import './/components/my_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final bankNameController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final bankAccountNumberController = TextEditingController();

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
    print("SSSSSSSSSS##################################");
    try {
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
          "phoneNumber": phone,
          "email": email,
          "dialCode": 91,
          "password": pass,
          "ifscCode": ifscCode,
          "accountNumber": accountNumber,
          "bankName": bankName,
        }),
      );
      print(response.body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status']) return true;
    } catch (e, s) {
      // handle manager failure of login
      print("$e.");
    }
    return true;
  }

  // email validation
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // phone number validation
  bool isValidPhoneNumber(String phone) {
    final mobileRegex = RegExp(r'^[6-9]\d{9}$');
    print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    return mobileRegex.hasMatch(phone);
  }

  // ifsc validation
  bool isValidIFSC(String ifsc) {
    final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    return ifscRegex.hasMatch(ifsc);
  }

  Future<void> onSubmitSignUp(BuildContext context) async {
    print("submit clicked");
    String firstName = firstNameController.text;
    String middleName = middleNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String phone = phoneNumberController.text;
    String pass = passwordController.text;
    String bankName = bankAccountNumberController.text;
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
    print("CCCCCCCCCCCC##############################################");
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please enter valid email!")));
      return;
    }
    print("EEEEEEEEEEEE##############################################");
    if (!isValidPhoneNumber(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid phone number!")),
      );
      return;
    }
    print("MMMMMMMMMMMMM##############################################");
    if (!(isValidIFSC(ifscCode))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter valid IFSC Code!")),
      );
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

    if (isAuthenticated){
      print("Account created successfully!");
      context.push("/dashboard");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid signup credentials')),
      );
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.black87,
                        size: 72.0,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
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
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16.0,
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
                            fontWeight: FontWeight.w500,
                            color: Colors.deepPurple,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Textfield(
                    controller: firstNameController,
                    hintText: 'First name',
                    obscureText: false,
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: middleNameController,
                    hintText: 'middle name',
                    obscureText: false,
                    prefixIcon: Icons.text_fields,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: lastNameController,
                    hintText: 'Last name',
                    obscureText: false,
                    prefixIcon: Icons.text_fields,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: emailController,
                    hintText: 'Email Address',
                    obscureText: false,
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: phoneNumberController,
                    hintText: 'Phone no',
                    obscureText: false,
                    prefixIcon: Icons.phone_android,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.password,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: bankNameController,
                    hintText: 'Bank name',
                    obscureText: false,
                    prefixIcon: Icons.account_balance,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: ifscCodeController,
                    hintText: 'IFSC Code',
                    obscureText: false,
                    prefixIcon: Icons.numbers,
                  ),
                  SizedBox(height: 15),
                  Textfield(
                    controller: bankAccountNumberController,
                    hintText: 'Account No',
                    obscureText: false,
                    prefixIcon: Icons.numbers,
                  ),
                  SizedBox(height: 45),
                  SizedBox(
                    height: 60.0,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => onSubmitSignUp(context),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Removes rounded corners
                        ),
                      ),
                      child: Text(
                        "Create your free account",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
