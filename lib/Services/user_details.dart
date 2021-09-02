import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Services/Provider.dart';
import 'package:image_picker/image_picker.dart';
import 'firebase_auth.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  get collection => null;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  bool edit;
  String dropdownValue = 'Male';
  TextEditingController ageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 200),
            alignment: Alignment.center,
            child: Text(
              'Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
              future: getUserInfo(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                      child: Container(
                    padding: EdgeInsets.fromLTRB(15, 25, 15, 0),
                    child: Column(
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            maxRadius: 60,
                            child: ClipOval(
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: (_image != null)
                                    ? Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        "",
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 90, top: 80),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_outlined),
                              onPressed: () {
                                setState(() {
                                  getImage();
                                });
                              },
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 5,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 40,
                              child: TextField(
                                enabled: edit,
                                controller: fullnameController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFF080B1E),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: snapshot.data.get('name'),
                                  hintStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  //labelText: 'Fullname',
                                  labelStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              padding: EdgeInsets.only(left: 255),
                              margin: EdgeInsets.only(top: 0),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    edit = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 25,
                          margin: EdgeInsets.only(top: 0),
                          child: TextField(
                            enabled: false,
                            textAlign: TextAlign.center,
                            controller: usernameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF080B1E),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: snapshot.data.get('displayName'),
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF939191),
                              ),
                              //labelText: 'Username',
                              labelStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              child: TextField(
                                enabled: edit,
                                textAlign: TextAlign.left,
                                controller: bioController,
                                maxLines: 11,
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(20),
                                  ),
                                  hintText: snapshot.data.get('bio'),
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              padding: EdgeInsets.only(left: 260),
                              margin: EdgeInsets.only(top: 105),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                iconSize: 30,
                                onPressed: () {
                                  setState(() {
                                    edit = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: TextField(
                            textAlign: TextAlign.left,
                            enabled: false,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFF080B1E),
                              hoverColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none
                              ),
                              hintText: "Age: " +snapshot.data.get('age').toString() + " years",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )); // from user's document retrieve name
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }

  Future<DocumentSnapshot> getUserInfo() async {
    var firebaseUser = await FirebaseAuth
        .instance.currentUser; //retrieve current user logged in
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseUser.uid)
        .get(); //get profile record of current user form firebase and return snapshot of document
  }
}
