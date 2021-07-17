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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          'Log In',
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
