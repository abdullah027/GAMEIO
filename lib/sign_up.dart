import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameio/firebase_auth.dart';
import 'package:gameio/welcome_page.dart';
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Color(0XFF1D1F33),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                textAlign: TextAlign.center,
                controller: nameController,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Color(0XFF1D1F33),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                textAlign: TextAlign.center,
                controller: emailController,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Email'),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Color(0XFF1D1F33),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: passwordController,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Password'),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: Color(0XFF1D1F33),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: cPasswordController,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'Confirm password'),
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
                  if(passwordController.text.trim() == cPasswordController.text.trim()){
                    context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );


                  }else{
                    emailController
                      ..text = "Passwords do not match"
                      ..selection = TextSelection.fromPosition(TextPosition(
                          offset: emailController.text.length,
                          affinity: TextAffinity.upstream));
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,),
                ),),
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
                  if(FirebaseAuth.instance.currentUser?.uid == null){
                    // not logged
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),         // logged
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                ),
                child: Text(
                  'GO',
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,),
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
