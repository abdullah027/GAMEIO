import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
              ),
              subtitle: Text('The basics of your profile'),
              title: Text(
                  'Account Information',
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
                Icons.lock,
              ),
              subtitle: Text('Options and controls for signing in and keeping your account safe'),
              title: Text(
                'Sign in & Security',
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
                Icons.remove_red_eye,
              ),
              subtitle: Text('Control who sees your activity and information on Gameio'),
              title: Text(
                'Visibility',
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
                Icons.email_outlined,
              ),
              subtitle: Text('Controls for invites and notifications'),
              title: Text(
                'Communication',
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
