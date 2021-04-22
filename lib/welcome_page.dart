import 'package:flutter/material.dart';
import 'package:gameio/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'map_page.dart';

dynamic user;
String userEmail = FirebaseAuth.instance.currentUser.email;


class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Welcome $userEmail",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Container(
            width: 150,
            height: 50,
            child: TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 150,
            height: 50,
            child: TextButton(
              child: Text('Log Out'),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEB1555)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
