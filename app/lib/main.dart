import 'package:flutter/material.dart';
import './pages/dashboad.dart';
import './pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String code = Uri.base.queryParameters['code'];
  String route;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: code != null ? '/dashboard' : '/',
      title: 'Babble',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Babble Bot'),
        '/dashboard': (context) => Dashboard(title: "DashBoard", code: code),
      },
    );
  }
}

