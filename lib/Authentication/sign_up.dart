

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gameio/Screens/map_page.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:gameio/Screens/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:gameio/Services/User_data.dart';

final auth = FirebaseAuth.instance;

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
              Flexible(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
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
                      width: double.infinity,
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
                      width: double.infinity,
                      height: 70,
                      padding: EdgeInsets.all(0),
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            if (passwordController.text.trim() ==
                                cPasswordController.text.trim()) {
                              handleSignUp().then({

                              });

                            } else {
                              Fluttertoast.showToast(msg: "Passwords do not match",gravity: ToastGravity.BOTTOM, backgroundColor: Colors.white,textColor: Colors.black, toastLength:Toast.LENGTH_LONG);
                            }
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
                          'Create Account',
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
                      onTap: () {
                        setState(() {
                          return context
                              .read<AuthenticationService>()
                              .signInWithGoogle();
                        });
                      },
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
                            image: AssetImage(
                              'assets/images/icons8-google-30.png',
                            ),
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
 handleSignUp() async{

    try{
      context.read<AuthenticationService>().signUp(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      //UserDatabaseService(uid: user.uid).setEmail(emailController.text.trim()); //add the users email to database so its accessible.
      UserDatabaseService(uid: user.uid).addUserData(
          nameController.text.trim(),
          0,
          "Gender",
          "Tell us a little about yourself",
          emailController.text
              .trim()); // set default parameters to user profile

    } on FirebaseAuthException catch (error){return error.message;
    }
  }
}
