import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/db/user_database.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), _checkAuth);
    super.initState();
  }

  _checkAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getString("token")?.isNotEmpty ?? false) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.grey),
                      SizedBox(height: 20),
                      Text("Loading please wait...")
                    ]))));
  }
}
