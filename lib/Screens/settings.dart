import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'help_center.dart';

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
            ListTile(
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
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 0.2,
            ),
            ListTile(
              leading: Icon(
                Icons.verified_user,
              ),
              title: Text(
                'User Agreement',
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
            ListTile(
              leading: Icon(
                Icons.notes_outlined,
              ),
              title: Text(
                'End User License Agreement',
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
            ListTile(
              onTap: () {
                context.read<AuthenticationService>().signOut();
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
