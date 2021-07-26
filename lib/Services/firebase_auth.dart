import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gameio/Services/User_data.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  User user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth;

  final GoogleSignIn _googleSignIn = GoogleSignIn();


  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  //Get Current Users UID
  Future<String> getCurrentUID() async {
    return  _firebaseAuth.currentUser.uid;
  }

  // Get Current User
  Future getCurrentUser() async {
    return  _firebaseAuth.currentUser;
  }


  /// Sign out user
  Future<void> signOut() async {
    UserDatabaseService(uid:user.uid ).isLoggedOut();
    return  _firebaseAuth.signOut();
  }

 

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({String email, String password}) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await result.user.reload();
      UserDatabaseService(uid:user.uid ).isLoggedIn();
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({String name, String email, String password}) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final uid = result.user.uid;
      await result.user.reload();
      await UserDatabaseService(uid:user.uid ).addUserData(name, 0, "Gender", "Tell us a little about yourself"); // set default parameters to user profile
      UserDatabaseService(uid:user.uid ).isLoggedIn();
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    UserDatabaseService(uid:user.uid ).isLoggedIn();
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }
}