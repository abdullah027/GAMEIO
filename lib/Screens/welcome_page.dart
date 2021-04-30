import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'map_page.dart';

dynamic user;
String userEmail = FirebaseAuth.instance.currentUser.email;

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 30.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Text(
                  "Welcome $userEmail",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  child: Text(
                      'Continue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: TextButton(
                  child: Text(
                      'Log Out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
