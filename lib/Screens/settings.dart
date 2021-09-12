import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Services/User_data.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:gameio/dialog/policy_dialog.dart';
import 'package:provider/provider.dart';

import 'Auth.dart';
import 'help_center.dart';
import 'map_page.dart';

final auth = FirebaseAuth.instance;

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 200),
            alignment: Alignment.center,
            child: Text(
              'Settings',
              style: TextStyle(
                //fontFamily: 'JuliusSansOne',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpCenter()),
                );
              },
              leading: Icon(
                Icons.help_center,
              ),
              title: Text(
                'Help Center',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 0.2,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'privacy_policy.md',
                      );
                    });
              },
              child: ListTile(
                leading: Icon(
                  Icons.privacy_tip_outlined,
                ),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 0.2,
            ),
            GestureDetector(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        mdFileName: 'terms_and_conditions.md',
                      );
                    });
              },
              child: ListTile(
                leading: Icon(
                  Icons.notes_sharp,
                ),
                title: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 0.2,
            ),
            ListTile(
              onTap: () {
                UserDatabaseService(uid: firebaseUser.uid).clearLocAndLogOut();
                // auth.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              leading: Icon(
                Icons.login_outlined,
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
