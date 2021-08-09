import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



import 'chat_screen.dart';


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

                return Column(children: [
                  ListTile(
                    tileColor: Color(0xFF363742),
                    leading: Icon(Icons.person),
                    trailing: IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
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