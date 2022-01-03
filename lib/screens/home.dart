import 'package:demo/screens/login.dart';
import 'package:demo/userStatus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  late final User user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserStatus loginStatus = UserStatus();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mainpage'),
        ),
        body: Center(
            child: Column(
          children: [
            Text('${auth.currentUser!.email}'),
            ElevatedButton(
                onPressed: () async {
                  await auth.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  });
                },
                child: Text('Logout'))
          ],
        )));
  }
}
