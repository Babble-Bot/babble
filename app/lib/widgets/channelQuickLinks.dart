import 'package:babble/models/babble/channel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChannelQuickLinks extends StatelessWidget {
  const ChannelQuickLinks(
      {Key key,
      @required this.channel,
      @required this.userName,
      this.width,
      this.height})
      : super(key: key);
  final double width;
  final double height;
  final BabbleChannel channel;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset('assets/theta.png',
                      scale: 3.5, fit: BoxFit.cover),
                  Row(
                    children: [Text("Open Chat"), Text("Open Stream")],
                  )
                ],
              ),
              Column(
                children: [
                  FaIcon(FontAwesomeIcons.twitch),
                  Row(
                    children: [Text("Coming Soon")],
                  )
                ],
              )
            ],
          )),
    );
  }
}
