
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/socialBar.dart';
import '../widgets/alertConfig.dart';
import '../widgets/socialLinks.dart';
import '../models/theta/auth.dart';
import '../models/theta/user.dart';
import '../models/babble/channel.dart';
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
  ThetaUser thetaUser;
  bool isLoading = true;
  void getDataFromAPI() async {
    thetaAuth = await ThetaApi().requestAuth(widget.code);
    if(thetaAuth.status == "SUCCESS"){
      channel = await BabbleApi().getChannel(thetaAuth.body.userId);
      thetaUser = await ThetaApi().getUser(thetaAuth.body.userId);
    }
    if(channel != null){
      setState(() {
        channel = channel;
        thetaUser = thetaUser;
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
              Text("Loading"),
              CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SocialBar()
                ]
              )
            ]
          )
        )
      );
    }else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(thetaUser.body.username),
              Container(
                width: 32,
                height: 32,
                padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(thetaUser.body.avatarUrl)
                    )
                )
              ),
            ],
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ]
            ),
            // IconButton(
            //   icon: Icon(Icons.settings),
            //   onPressed: (){},
            // ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlertConfigCard(config: channel.body.alertConfig, width: 300),
                    //SocialLinksCard(config: channel.body.alertConfig, width: 300)
                  ],
                )
              ]
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SocialBar()
              ]
            )
          ],
        )
        );
    }
  }
}