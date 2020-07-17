import 'package:babble/utils/babbleApi.dart';
import 'package:flutter/material.dart';
import '../models/babble/channel.dart';

class AlertConfigCard extends StatefulWidget {
  AlertConfigCard(
      {Key key,
      @required this.config,
      @required this.channel,
      this.height,
      this.width})
      : super(key: key);
  double height;
  double width;
  AlertConfig config;
  BabbleChannel channel;

  @override
  _AlertConfigCard createState() =>
      _AlertConfigCard(config, channel, height, width);
}

class _AlertConfigCard extends State<AlertConfigCard> {
  _AlertConfigCard(config, channel, height, width);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        width: widget.width,
        height: widget.height,
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
                  value: widget.config.all,
                  onChanged: (bool value) => updateAlertConfig(value, "all"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Hello:"),
                Switch(
                  value: widget.config.hello,
                  onChanged: (bool value) => updateAlertConfig(value, "hello"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Donation:"),
                Switch(
                  value: widget.config.donation,
                  onChanged: (bool value) =>
                      updateAlertConfig(value, "donation"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Follow:"),
                Switch(
                  value: widget.config.follow,
                  onChanged: (bool value) => updateAlertConfig(value, "follow"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Gift:"),
                Switch(
                  value: widget.config.gift,
                  onChanged: (bool value) => updateAlertConfig(value, "gift"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Subs:"),
                Switch(
                  value: widget.config.sub,
                  onChanged: (bool value) => updateAlertConfig(value, "sub"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Gifted Subs:"),
                Switch(
                  value: widget.config.giftedsub,
                  onChanged: (bool value) =>
                      updateAlertConfig(value, "giftedsub"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Level:"),
                Switch(
                  value: widget.config.level,
                  onChanged: (bool value) => updateAlertConfig(value, "level"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Quiz:"),
                Switch(
                  value: widget.config.quiz,
                  onChanged: (bool value) => updateAlertConfig(value, "quiz"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Raffle:"),
                Switch(
                  value: widget.config.raffle,
                  onChanged: (bool value) => updateAlertConfig(value, "raffle"),
                )
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Win Raffle:"),
                Switch(
                  value: widget.config.rafflewin,
                  onChanged: (bool value) =>
                      updateAlertConfig(value, "rafflewin"),
                )
              ]),
        ]),
      ),
    );
  }

  Future<void> updateAlertConfig(bool value, String key) async {
    BabbleApi babbleAip = BabbleApi();
    switch (key) {
      case "all":
        widget.channel.body.alertConfig.all = value;
        break;
      case "hello":
        widget.channel.body.alertConfig.hello = value;
        break;
      case "donation":
        widget.channel.body.alertConfig.donation = value;
        break;
      case "follow":
        widget.channel.body.alertConfig.follow = value;
        break;
      case "gift":
        widget.channel.body.alertConfig.gift = value;
        break;
      case "sub":
        widget.channel.body.alertConfig.sub = value;
        break;
      case "giftedsub":
        widget.channel.body.alertConfig.giftedsub = value;
        break;
      case "level":
        widget.channel.body.alertConfig.level = value;
        break;
      case "quiz":
        widget.channel.body.alertConfig.quiz = value;
        break;
      case "raffle":
        widget.channel.body.alertConfig.raffle = value;
        break;
      case "rafflewin":
        widget.channel.body.alertConfig.rafflewin = value;
        break;
    }
    widget.channel = await babbleAip.updateChannel(widget.channel);
    setState(() {
      widget.config = widget.channel.body.alertConfig;
    });
  }
}
