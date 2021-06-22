import 'package:flutter/material.dart';
import 'package:test/views/home.dart';
import 'package:test/views/login.dart';
import 'package:test/views/register.dart';
import 'package:test/views/splash.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
      case 'register':
        return MaterialPageRoute(builder: (_) => Register());
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: Center(child: Text('Page not found'))));
    }
  }
}
