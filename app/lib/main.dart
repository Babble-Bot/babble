import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/dashboad.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  String code = Uri.base.queryParameters['code'];

  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {
      '/': (BuildContext context) => MyHomePage(),
      '/dashboard': (BuildContext context) => Dashboard()
    };
    return MaterialApp(
      initialRoute: '/',
      routes: routes,
      title: 'Babble',
      debugShowCheckedModeBanner: true,//change once fully lanched 
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
    );
  }
}

