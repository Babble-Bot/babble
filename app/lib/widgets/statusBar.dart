import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/babble/installs.dart';

class StatusBar extends StatelessWidget {
  StatusBar({@required this.installs});
  final BabbleInstalls installs;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(children: [
        Row(children: [
          Text("Installs"),
        ]),
        Row(children: [
          Column(
            children: [
              Image.asset('assets/theta.png', scale: 3.5, fit: BoxFit.cover),
              Text("${installs.body.theta}")
            ],
          ),
          Column(
            children: [
              FaIcon(FontAwesomeIcons.twitch),
              Text("${installs.body.twitch}")
            ],
          )
        ])
      ])
    ]);
  }
}
