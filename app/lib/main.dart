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
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(title: 'Babble Bot'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/dashboard': (context) => Dashboard(title: "DashBoard"),
      },
    );
  }
}

