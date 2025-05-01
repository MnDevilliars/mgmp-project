import 'package:flutter/material.dart';
import 'package:flutterxlayer01/components/my_button.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void handleAdminLogin() {
    print("Admin Login Handle");
  }

  void handleManagerLogin() {
    print("Manager Login Handle");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            // Upper part
            child:  Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/mgmp-background.jpg",
                    width: 300,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Container(
                      // color: Colors.black.withOpacity(0.3)
                  ),
                  // Centered text
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: [
                          SizedBox(height: 150,),
                          Image.asset(
                            "assets/images/mgmp-logo.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 15,),
                          ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Color(0xFF9ACD32), Color(0xFF6B8E23)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                            child: Text(
                              "Welcome to Meghalaya Grassroots Music Project",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 36.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
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
                          SizedBox(height: 100),
                          MyButton(
                            label: "Login as Admin",
                            onPressed: handleAdminLogin,
                            url: '/admin-login',
                          ),
                          SizedBox(height: 30),
                          MyButton(
                            label: "Login as Manager",
                            onPressed: handleManagerLogin,
                            url: '/manager-login',
                          ),
                          SizedBox(height: 75),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "not a member ? ",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                              GestureDetector(
                                onTap: () {
                                  context.push('/signup');
                                },
                                child: Text(
                                  " register now",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
