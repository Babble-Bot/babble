import 'package:flutter/material.dart';
import '../models/babble/channel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLinksCard extends StatefulWidget {
  SocialLinksCard({Key key, this.config, this.height, this.width}) : super(key: key);
  final double height;
  final double width;
  AlertConfig config;
  @override
  _socialLinksCardState createState() => _socialLinksCardState();
}

class _socialLinksCardState extends State<SocialLinksCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child:Container(
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.all(20),
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  // Icon(Icons.notifications_active, color: Colors.lightBlue),
                  Text("Social Links"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ FaIcon(FontAwesomeIcons.twitter), TextField( obscureText: true, decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'Twitter',),)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ FaIcon(FontAwesomeIcons.twitch), TextField( obscureText: true, decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'Twitch',),)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ FaIcon(FontAwesomeIcons.youtube), TextField( obscureText: true, decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'YouTube',),)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ FaIcon(FontAwesomeIcons.discord), TextField( obscureText: true, decoration: InputDecoration( border: OutlineInputBorder(), labelText: 'Discord',),)]
              )
            ]
          ),
        ),
      );
  }
}