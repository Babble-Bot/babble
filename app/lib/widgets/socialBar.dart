import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialBar extends StatelessWidget {
  const SocialBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.twitter),
            onPressed: () {
              launch('https://twitter.com/BABBLECHATBOT', forceSafariVC: false);
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.trello),
            onPressed: () {
              launch('https://trello.com/b/ouoA0dci/babble-roadmap', forceSafariVC: false);
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.patreon),
            onPressed: () {
              launch('https://www.patreon.com/babblechatbot', forceSafariVC: false);
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.github),
            onPressed: () {
              launch('https://github.com/Babble-Bot/thetabot', forceSafariVC: false);
            },
          ),
        ],
    );
  }
}