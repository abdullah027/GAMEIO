import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gameio/Screens/profile_view_other.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'chat_view.dart';


class DataSearch extends SearchDelegate<String> {

  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('Users');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.where('isloggedin', isEqualTo: true).get();
    print(FirebaseAuth.instance.currentUser.email);

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
                if(snapshot.data[index]['email'] == FirebaseAuth.instance.currentUser.email){
                  return Container(height: 0);
                }
                return Column(children: [
                  ListTile(
                    tileColor: Color(0XFF1D1F33),
                    leading: IconButton(icon: Icon(Icons.person),
                      onPressed: ()async{
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileViewOther(snapshot.data[index])));
                    },),
                    trailing: IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.setString('email', snapshot.data[index]['email'].toString());
                        //print(snapshot.data[index]['email']+"************************");
                        pref.setString('name', snapshot.data[index]['name'].toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                      },
                    ),
                    title: Text(suggestionList[index]['name'].toString()),
                    subtitle:
                    Text(suggestionList[index]['country'].toString()),
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
