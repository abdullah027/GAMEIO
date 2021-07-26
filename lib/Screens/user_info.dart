import 'dart:io';
//import 'dart:js_util';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/Screens/fill_info.dart';
import 'package:gameio/Screens/welcome_page.dart';
import 'package:gameio/Services/User_data.dart';
//import 'package:age/age.dart';
//import 'package:gameio/Screens/map_page.dart';
import 'package:gameio/Services/firebase_auth.dart';
import 'package:gameio/Services/user_details.dart';
import 'package:gameio/Services/user_details.dart';
//import 'package:provider/provider.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:gameio/Services/User_data.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  User user = FirebaseAuth.instance.currentUser;

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

  String name;
  String bio;
  String age;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Container(
            margin: EdgeInsets.only(right: 150),
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundColor: Color(0xFFEB1555),
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
                            "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              //SizedBox(
              // height: 20,
              //),
              Flexible(
                child: Container(
                  width: 300,
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFF1D1F33),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: 'ss',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      labelText: 'Username',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  width: 300,
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFF1D1F33),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      hintText: user.displayName,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      labelText: 'Full Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: 360,
                  child: TextField(
                    enabled: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: 11,
                    textAlign: TextAlign.left,
                    cursorColor: Colors.red,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFF1D1F33),
                      hoverColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Bio',
                      hintText: bio,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              //SizedBox(
              //height: 25,
              //),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 50,
                  width: 110,
                  alignment: Alignment.center,
                  child: TextField(
                    enabled: false,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFF1D1F33),
                      hoverColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelText: 'Age',
                      hintText: age,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              //SizedBox(
              // height: 100,
              //),
            ],
          ),
        ),
      ),
    );
  }
}
