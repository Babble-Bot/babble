import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/socialBar.dart';
import '../utils/thetaApi.dart';
import '../models/ThetaAuth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final String code = Uri.base.queryParameters['code'];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    if(widget.code != null){
      final ThetaAuth = requestAuth(widget.code);
      if(ThetaAuth != null){
        Navigator.pushNamed(context, '/dashboard');
      }
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

