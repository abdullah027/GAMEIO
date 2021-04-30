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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      textAlign: TextAlign.center,
                      controller: emailController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Email'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      controller: passwordController,
                      cursorColor: Colors.red,
                      decoration: InputDecoration(
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: 'Password'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 65,
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          context.read<AuthenticationService>().signIn(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),

                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                        ),
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),),
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
