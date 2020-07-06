import 'package:babble/utils/babbleApi.dart';
import 'package:flutter/material.dart';
import '../models/babble/channel.dart';

class AlertConfigCard extends StatelessWidget {
  AlertConfigCard(
      {@required this.config, @required this.channel, this.height, this.width});
  double height;
  double width;
  AlertConfig config;
  BabbleChannel channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
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
                  onChanged: (bool value) => updateAlertConfig(value, "all"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Hello:"),
                Switch(
                  value: config.hello,
                  onChanged: (bool value) => updateAlertConfig(value, "hello"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Donation:"),
                Switch(
                  value: config.donation,
                  onChanged: (bool value) =>
                      updateAlertConfig(value, "donation"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Follo:"),
                Switch(
                  value: config.follow,
                  onChanged: (bool value) => updateAlertConfig(value, "follow"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Gift:"),
                Switch(
                  value: config.gift,
                  onChanged: (bool value) => updateAlertConfig(value, "gift"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Subs:"),
                Switch(
                  value: config.sub,
                  onChanged: (bool value) => updateAlertConfig(value, "sub"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Gifted Subs:"),
                Switch(
                  value: config.giftedsub,
                  onChanged: (bool value) =>
                      updateAlertConfig(value, "giftedsub"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Level:"),
                Switch(
                  value: config.level,
                  onChanged: (bool value) => updateAlertConfig(value, "level"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Quiz:"),
                Switch(
                  value: config.quiz,
                  onChanged: (bool value) => updateAlertConfig(value, "quiz"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Raffle:"),
                Switch(
                  value: config.raffle,
                  onChanged: (bool value) => updateAlertConfig(value, "raffle"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Win Raffle:"),
                Switch(
                  value: config.rafflewin,
                  onChanged: (bool value) =>
                      updateAlertConfig(value, "rafflewin"),
                )
              ]),
        ]),
      ),
    );
  }

  void updateAlertConfig(bool value, String key) {
    BabbleApi babbleAip = BabbleApi();
    switch (key) {
      case "all":
        channel.body.alertConfig.all = value;
        break;
      case "hello":
        channel.body.alertConfig.hello = value;
        break;
      case "donation":
        channel.body.alertConfig.donation = value;
        break;
      case "follow":
        channel.body.alertConfig.follow = value;
        break;
      case "gift":
        channel.body.alertConfig.gift = value;
        break;
      case "sub":
        channel.body.alertConfig.sub = value;
        break;
      case "giftedsub":
        channel.body.alertConfig.giftedsub = value;
        break;
      case "level":
        channel.body.alertConfig.level = value;
        break;
      case "quiz":
        channel.body.alertConfig.quiz = value;
        break;
      case "raffle":
        channel.body.alertConfig.raffle = value;
        break;
      case "rafflewin":
        channel.body.alertConfig.rafflewin = value;
        break;
    }
    channel = babbleAip.updateChannel(channel) as BabbleChannel;
    config = channel.body.alertConfig;
  }
}
