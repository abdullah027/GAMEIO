import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String image;
  String name;
  String receiverEmail;
  String username;
  int age;
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
      image = pref.getString('image');
      name = pref.getString('name');
      receiverEmail = pref.getString('email');
      username = pref.getString('username');
      age = pref.getInt('age');
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
                  padding: const EdgeInsets.only(top: 23),
                  child: Center(
                    child: CircleAvatar(
                      maxRadius: 70,
                      backgroundColor: Colors.black38,
                      child: ClipOval(
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: Image.network(image,fit: BoxFit.fill,),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 170),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                      height: 55,
                      width: 225,
                      child: TextButton(
                        onPressed: () async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.setString('email', receiverEmail);
                          pref.setString('name', name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
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
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 230),
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
                            'Age',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          subtitle: Text(
                            age.toString(),
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
                            country.toString(),
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
                            discord.toString(),
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
                            bio.toString(),
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
          ],
        ),
      ),
    );
  }
}
