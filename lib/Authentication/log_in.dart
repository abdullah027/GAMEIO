//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'map_page.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 200),
            alignment: Alignment.center,
            child: Text(
              'Log in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            padding: EdgeInsets.only(top: 30),
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Log in with one of the followings."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => print("LogIn with Google"),
                    child: Container(
                      //margin: EdgeInsets.only(top: 200),
                      height: 80,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF080B1E),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFD9BEBE),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/icons8-google-30.png',),
                        ),
                    ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('Login with Facebook'),
                    child: Container(
                      //margin: EdgeInsets.only(top: 200),
                      height: 80,
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF080B1E),
                        border: Border.all(
                          width: 1,
                          color: Color(0xFFD9BEBE),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/images/icons8-facebook-30.png',),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 330),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: emailController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'harrywilson@email.com'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 305),
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                          ),
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Enter your Password'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 65,
                      width: 380,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          });
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFEB1555)),
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Dont have an Account? Sign up"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
