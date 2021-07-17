import 'package:firebase_auth/firebase_auth.dart';
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
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 350),
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
            Flexible(
              child: Container(
                color: Color(0xFF080B1E),
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(left: 10, right: 10),
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
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 350),
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
            Flexible(
              child: Container(
                color: Color(0xFF080B1E),
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(left: 10, right: 10),
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
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 320),
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
            Flexible(
              child: Container(
                color: Color(0xFF080B1E),
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(left: 10, right: 10),
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
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 260),
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
            Flexible(
              child: Container(
                color: Color(0xFF080B1E),
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(left: 10, right: 10),
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
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(
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
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
