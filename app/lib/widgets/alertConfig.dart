import 'package:flutter/material.dart';
import '../models/babble/channel.dart';

class AlertConfigCard extends StatefulWidget {
  AlertConfigCard({Key key, this.config, this.height, this.width}) : super(key: key);
  final double height;
  final double width;
  AlertConfig config;
  @override
  _alertConfigCardState createState() => _alertConfigCardState();
}

class _alertConfigCardState extends State<AlertConfigCard> {
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
                  Icon(Icons.notifications_active, color: Colors.lightBlue),
                  Text("Bot Alert Config"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("All:"), Switch(value: widget.config.all, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("Hello:"), Switch(value: widget.config.hello, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("Hello:"), Switch(value: widget.config.donation, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("Hello:"), Switch(value: widget.config.follow, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text("Hello:"), Switch(value: widget.config.gift, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text("Hello:"), Switch(value: widget.config.sub, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text("Hello:"), Switch(value: widget.config.giftedsub, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("Hello:"), Switch(value: widget.config.level, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("Hello:"), Switch(value: widget.config.quiz, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("Hello:"), Switch(value: widget.config.raffle, onChanged: (bool value) {  },)]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[ Text("Hello:"), Switch(value: widget.config.rafflewin, onChanged: (bool value) {  },)]
              ),
            ]
          ),
        ),
      );
  }
}