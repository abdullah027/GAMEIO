import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'map_page.dart';
import 'package:gameio/firebase_auth.dart';
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
              height: 10,
            ),
            Container(
              width: 150,
              height: 50,
              padding: EdgeInsets.all(0),
              child: TextButton(
                onPressed: () {
                  //context.read<AuthenticationService>().signIn(
                    //email: emailController.text.trim(),
                    //password: passwordController.text.trim(),
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage())
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
