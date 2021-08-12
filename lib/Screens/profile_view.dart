import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String name;
  String username;
  String age;
  String country;
  String discord;
  String bio;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      name = pref.getString('name');
      username = pref.getString('username');
      age = pref.getString('age');
      country = pref.getString('country');
      discord = pref.getString("discord_ID");
      bio = pref.getString("bio");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 200),
            alignment: Alignment.center,
            child: Text(
              'ProileView',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/gamepad.jpg"),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 1,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        name,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Username',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        username,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Country',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        'null',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
