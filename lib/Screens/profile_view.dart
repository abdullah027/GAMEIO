import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Screens/profile_edit_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  User firebaseUser = FirebaseAuth.instance.currentUser;
  Map data;

  fetchData() {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("Users");
    collectionReference.doc(firebaseUser.uid).snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.data();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          child: Stack(
        children: <Widget>[
          ListView(
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
                    padding: const EdgeInsets.only(top: 23),
                    child: Center(
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
                          data['userName'],
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
                          data['country'].toString(),
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
                          data['discord_username'].toString(),
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
                          data['bio'].toString(),
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
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FillInfo()));
                });
              },
              backgroundColor: Colors.amber,
              child: Icon(Icons.edit),
            ),
          ),
        ],
      )),
    );
  }
}
