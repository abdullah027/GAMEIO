import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gameio/Screens/map_page.dart';
import 'package:gameio/Screens/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'chat_view.dart';


class DataSearch extends SearchDelegate<String> {

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('Users');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final data = querySnapshot.docs.map((doc) => doc.data()).toList();

    return data;
  }





  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for AppBar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Card(
          color: Colors.red,
        ),
      ),
    );

  }
  @override
  Widget buildSuggestions(BuildContext context) {

    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final suggestionList = query.isEmpty ?  snapshot.data : snapshot.data;
            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                setProfileData()async{
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString('image', snapshot.data[index]['avatarUrl']);
                  pref.setString('name', snapshot.data[index]['name']);
                  pref.setString('email', snapshot.data[index]['email']);
                  pref.setString('username', snapshot.data[index]['userName']);
                  pref.setInt('age', snapshot.data[index]['age']);
                  pref.setString('country', snapshot.data[index]['country']);
                  pref.setString('discord_ID', snapshot.data[index]['discord_username']);
                  pref.setString('bio', snapshot.data[index]['bio']);
                }
                if(snapshot.data[index]['email'] == FirebaseAuth.instance.currentUser.email){
                  return Container(height: 0);
                }
                return Column(children: [
                  ListTile(
                    tileColor: Color(0XFF1D1F33),
                    leading: IconButton(icon: Icon(Icons.person),
                      onPressed: ()async{
                      setProfileData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileView()));
                    },),
                    trailing: IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setString('email', snapshot.data[index]['email']);
                        pref.setString('name', snapshot.data[index]['name']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      },
                    ),
                    title: Text(suggestionList[index]['name']),
                    subtitle:
                    Text(suggestionList[index]['country']),
                  ),
                  Container(
                    color: Color(0xFF0A0D22),
                    height: 1,
                  ),
                ]);
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });

  }
}
