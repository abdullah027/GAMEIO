//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:gameio/Screens/welcome_page.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 200),
            alignment: Alignment.center,
            child: Text(
              'Sign up',
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
          margin: EdgeInsets.only(top: 0),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            padding: EdgeInsets.only(top: 30),
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Sign up with one of the following options."),
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
                    onTap: () => print('Sign up with Facebook'),
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
                        "Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Color(0xFF080B1E),
                      child: TextField(
                        controller: nameController,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Harry Wilson',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                    Container(
                      color: Color(0xFF080B1E),
                      child: TextField(
                        controller: emailController,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'harrywilson@email.com'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 300),
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
                    Container(
                      color: Color(0xFF080B1E),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Enter your password'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 240),
                      child: Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Color(0xFF080B1E),
                      child: TextField(
                        obscureText: true,
                        controller: cPasswordController,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            hoverColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Confirm your password'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 390,
                      height: 50,
                      padding: EdgeInsets.all(0),
                      child: TextButton(
                        onPressed: () {
                          if (passwordController.text.trim() ==
                              cPasswordController.text.trim()) {
                            context.read<AuthenticationService>().signUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                          } else {
                            emailController
                              ..text = "Passwords do not match"
                              ..selection = TextSelection.fromPosition(TextPosition(
                                  offset: emailController.text.length,
                                  affinity: TextAffinity.upstream));
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                        ),
                        child: Text(
                          'Create Account',
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
                    Container(
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.all(0),
                      child: TextButton(
                        onPressed: () {
                          // if(FirebaseAuth.instance.currentUser?.uid == null){
                          // not logged
                          //} else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()), // logged
                          );
                          //}
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                        ),
                        child: Text(
                          'GO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
