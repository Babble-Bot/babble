import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/babble/installs.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({Key key, BabbleInstalls installs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var installs = Provider.of<BabbleInstalls>(context);
    if(installs != null){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children:[
              Row(
                children:[
                  Text("Stats"),
                ]
              ),
              Row(
                children:[
                  Column(
                    children: [
                      Image.asset('assets/theta.png',scale: 3.5, fit: BoxFit.cover),
                      Text("${installs.body.theta}")
                    ],
                  ),
                  Column(
                    children: [
                      FaIcon(FontAwesomeIcons.twitch),
                      Text("${installs.body.twitch}")
                    ],
                  )
                ]
              )
            ]
          )
        ]
      );
    }else{
      return CircularProgressIndicator( backgroundColor: Colors.lightBlue);
    }
  }
}