import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'chat_screen.dart';


class DataSearch extends SearchDelegate<String> {
  var user = FirebaseAuth.instance.currentUser;



  final players = [
    "John Doe",
    "Harry Wilson",
    "Farhan Ali",
    "Esa Khan",
    "Esha Ali",
    "Samar Khan",
    "Amal Ahmed",
    "Ron Weisely",
    "Barry Allen",
    "Iris West",
    "Bruce Wayne",
    "Clark Kent",
    "Louis Lane",
    "Cisco"
  ];
  final recentSearch = [
    "John Doe",
    "Harry Wilson",
    "Farhan Ali",
    "Esa Khan",
  ];
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
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentSearch : players.where((p) => p.startsWith(query)).toList();

    return ListView.builder(
        itemBuilder: (context, index) => ListTile(
              onTap: (){
                showResults(context);
              },
              leading: Icon(Icons.person_rounded),
              trailing: IconButton(icon: Icon(Icons.message),iconSize: 20,onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
              },),
              title: Text(suggestionList[index]),
            ),
      itemCount: suggestionList.length,
    );
  }
}
