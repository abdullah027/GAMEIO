class User{
  String uid;
  String name;
  bool admin;

  User(this.uid);

  Map<String, dynamic> toJson() =>{
    'uid': uid,
    'name': name,
  };
}