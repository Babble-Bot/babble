import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/socialBar.dart';
import '../models/theta-auth.dart';
import '../models/babble-channel.dart';
import '../utils/thetaApi.dart';
import '../utils/babbleApi.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title, this.code}) : super(key: key);
  final String title;
  final String code;
  @override
  _DashboardStatus createState() => _DashboardStatus();
}

class _DashboardStatus extends State<Dashboard> {
  BabbleChannel channel;
  ThetaAuth thetaAuth;
  bool isLoading = true;
  void getDataFromAPI() async {
    thetaAuth = await ThetaApi().requestAuth(widget.code);
    if(thetaAuth.status == "SUCCESS"){
      channel = await BabbleApi().getChannel(thetaAuth.body.userId);
    }
    if(channel != null){
      setState(() {
        channel = channel;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (channel == null ){
      getDataFromAPI();
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              )
            ]
          )
        )
      );
    }else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("${channel.body.clientId}"),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SocialBar()
                ]
              )
            ],
          )
        )
      );
    }
  }
}