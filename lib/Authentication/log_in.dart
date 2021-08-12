//import 'dart:html';

import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'map_page.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:gameio/Screens/map_page.dart';
import 'package:gameio/Screens/main.dart';

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
              Column(
                children: [
                  Container(
                    width: double.infinity,
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
                    width: double.infinity,
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
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {

                          setState(() {
                            context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ).then((value) =>  Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) =>MapPage(),),),
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
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white,)),
                      SizedBox(
                        width: 20,
                      ),
                      Text('or sign up with'),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Divider(color: Colors.white,)),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () =>context.read<AuthenticationService>().signInWithGoogle(),
                    child: Container(
                      //margin: EdgeInsets.only(top: 200),
                      height: 65,
                      width: double.infinity,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


