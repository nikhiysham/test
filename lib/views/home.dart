import 'package:flutter/material.dart';
import 'package:test/views/drawer.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scKey,
        appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scKey.currentState?.openDrawer();
                })),
        drawer: LeftDrawer(),
        body: SafeArea(child: Container(child: Text('This is home screen'))));
  }
}
