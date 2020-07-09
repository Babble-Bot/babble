import 'package:flutter/material.dart';
import '../models/babble/channel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLinksCard extends StatelessWidget {
  SocialLinksCard({@required this.config, this.height, this.width});
  final _formKey = GlobalKey<FormState>();
  final double height;
  final double width;
  SocialLinks config;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          width: width,
          height: height,
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Social Links"),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: FaIcon(FontAwesomeIcons.twitter,
                              color: Colors.lightBlue),
                          hintText: 'Twitter',
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: FaIcon(FontAwesomeIcons.twitch,
                              color: Color.fromARGB(255, 169, 112, 255)),
                          hintText: 'Twitch',
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: FaIcon(FontAwesomeIcons.youtube,
                              color: Colors.red),
                          hintText: 'YouTube',
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: FaIcon(FontAwesomeIcons.discord,
                              color: Color.fromARGB(255, 114, 137, 218)),
                          hintText: 'Discord',
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                        child: Text('Submit'),
                      )),
                ]),
          ),
        ));
  }
}
