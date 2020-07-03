import 'package:flutter/material.dart';
import '../models/babble/channel.dart';

class AlertConfigCard extends StatelessWidget {
  AlertConfigCard({@required this.config, this.height, this.width});
  double height;
  double width;
  AlertConfig config;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_active, color: Colors.lightBlue),
                  Text("Bot Alert Config"),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("All:"),
                    Switch(
                      value: config.all,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Hello:"),
                    Switch(
                      value: config.hello,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Donation:"),
                    Switch(
                      value: config.donation,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Follo:"),
                    Switch(
                      value: config.follow,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Gift:"),
                    Switch(
                      value: config.gift,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subs:"),
                    Switch(
                      value: config.sub,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Gifted Subs:"),
                    Switch(
                      value: config.giftedsub,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Level:"),
                    Switch(
                      value: config.level,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Quiz:"),
                    Switch(
                      value: config.quiz,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Raffle:"),
                    Switch(
                      value: config.raffle,
                      onChanged: (bool value) {},
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Win Raffle:"),
                    Switch(
                      value: config.rafflewin,
                      onChanged: (bool value) {},
                    )
                  ]),
            ]),
      ),
    );
  }
}
