import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameio/home_page.dart';
//import 'package:gameio/log_in.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:gameio/firebase_auth.dart';
//import 'map_page.dart';
import 'welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthenticationService>().authStateChanges,
          )
        ],
        child:MaterialApp(
          theme: ThemeData.dark().copyWith(
            primaryColor: Color(0xFF0A0D22),
            scaffoldBackgroundColor: Color(0xFF080B1E),
          ),
          home: AuthenticationWrapper(),
        ));
  }
}
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return WelcomeScreen();
    }
    return HomePage();
  }
}

