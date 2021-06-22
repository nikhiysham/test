import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeftDrawer extends StatelessWidget {
  LeftDrawer();

  @override
  Widget build(BuildContext context) {
    TextStyle txtStyle = new TextStyle(color: Colors.white);

    return Drawer(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.lightGreen,
            child: ListView(
              children: [
                ListTile(
                    title: Text("Home", style: txtStyle),
                    leading: Icon(Icons.home, color: Colors.white),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    }),
                ListTile(
                    title: Text("Logout", style: txtStyle),
                    leading: Icon(Icons.logout, color: Colors.white),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                                title: Text("Are you sure to Logout?"),
                                actions: [
                                  MaterialButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        pref.setString('token', "");
                                        Navigator.of(context)
                                          ..pop()
                                          ..pushReplacementNamed('login');
                                      }),
                                  MaterialButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ]);
                          });
                    })
              ],
            )));
  }
}
