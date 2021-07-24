import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:gameio/Services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gameio/Services/User_data.dart';
//import 'package:provider/provider.dart';
import 'map_page.dart';
//import 'package:gameio/Models/User.dart';
//import 'package:gameio/Services/Provider.dart';

dynamic user;
String username = FirebaseAuth.instance.currentUser.displayName;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}


class _WelcomeScreen extends State<WelcomeScreen> {
  User user = FirebaseAuth.instance.currentUser;

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
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Welcome $username" ,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
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
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
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
