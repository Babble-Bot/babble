import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/socialBar.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final String code = Uri.base.queryParameters['code'];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void auth(String code) async {
    var url = 'https://api.theta.tv/v1/oauth/token?client_id=nrw8kbwfew3zbyedmyn26ybxu0ixpiue&client_secret=pb6aesq10kqsebp3ztxz1cn7hgztegvr&grant_type=authorization_code&code='+code;

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print('json: $jsonResponse.');
      Navigator.pushNamed(context, '/dashboard');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  @override
  Widget build(BuildContext context) {
    if(widget.code != ''){
      auth(widget.code);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to Babble'),
            Image.asset('assets/babble.png',scale:10,fit: BoxFit.cover,),
            RaisedButton(
              child: Text('Login With Theta'),
              color: Colors.white,
              onPressed: () {
                launch('https://www.theta.tv/account/grant-app?client_id=nrw8kbwfew3zbyedmyn26ybxu0ixpiue&redirect_uri=http://babblechatbot.com/', forceSafariVC: false);
              },
            ),
            SocialBar(),
          ],
        ),
      ),
    );
  }
}

