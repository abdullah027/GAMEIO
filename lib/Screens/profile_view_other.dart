import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Screens/profile_edit_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_view.dart';

class ProfileViewOther extends StatelessWidget {
  final Map data;
  ProfileViewOther(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            label: Text(''),
          ),
        ],
        title: Center(
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 35),
                  child: CircleAvatar(
                    maxRadius: 70,
                    backgroundColor: Colors.black38,
                    child: ClipOval(
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.network(
                          data['avatarUrl'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 105, left: 190),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    height: 55,
                    width: 180,
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString('email', data['email'].toString());
                        pref.setString('name', data['name'].toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                      ),
                      child: Text(
                        'message',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
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
                        data['name'],
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
                        data['displayName'],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Age',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        data['age'].toString(),
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
                        data['country'],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'DiscordID',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        data['discord_username'],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      dense: true,
                      title: Text(
                        'Bio',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: Text(
                        data['bio'],
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
