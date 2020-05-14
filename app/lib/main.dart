import 'package:flutter/material.dart';
import './pages/dashboad.dart';
import './pages/home.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      title: 'Babble',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Babble Bot'),
        '/dashboard': (context) => Dashboard(title: "DashBoard"),
      },
    );
  }
}

