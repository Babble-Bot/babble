import 'package:babble/utils/babbleApi.dart';
import 'package:flutter/material.dart';
import '../models/babble/channel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomeComandsCard extends StatefulWidget {
  CustomeComandsCard(
      {Key key,
      @required this.config,
      @required this.channel,
      this.height,
      this.width})
      : super(key: key);
  double height;
  double width;
  SocialLinks config;
  BabbleChannel channel;

  @override
  _CustomeComandsCard createState() =>
      _CustomeComandsCard(config, channel, height, width);
}

class _CustomeComandsCard extends State<CustomeComandsCard> {
  _CustomeComandsCard(config, channel, height, width);
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};

  @override
  void initState() {
    super.initState();
    //foreach to build comand list of inputs
  }

  Future<void> updateSocialLinks() async {
    BabbleApi babbleAip = BabbleApi();
    widget.channel.body.customeCmds = [];
    widget.channel = await babbleAip.updateChannel(widget.channel);
    setState(() {
      widget.config = widget.channel.body.customCmds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Social Links"),
                  _twitterInput(),
                  _twitchInput(),
                  _youtubeInput(),
                  _discordInput(),
                  _submitButton(),
                ]),
          ),
        ));
  }

  Widget _twitterInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
              labelText: 'Twitter',
              hintText: widget.config.twitter),
          onSaved: (val) => setState(() => formData['twitter'] = val),
        ));
  }

  Widget _twitchInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: FaIcon(FontAwesomeIcons.twitch,
                  color: Color.fromARGB(255, 169, 112, 255)),
              labelText: 'Twitch',
              hintText: widget.config.twitch),
          onSaved: (val) => setState(() => formData['twitch'] = val),
        ));
  }

  Widget _youtubeInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red),
              labelText: 'YouTube',
              hintText: widget.config.youtube),
          onSaved: (val) => setState(() => formData['youtube'] = val),
        ));
  }

  Widget _discordInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: FaIcon(FontAwesomeIcons.discord,
                  color: Color.fromARGB(255, 114, 137, 218)),
              labelText: 'Discord',
              hintText: widget.config.discord),
          onSaved: (val) => setState(() => formData['discord'] = val),
        ));
  }

  Widget _submitButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {
            // Validate will return true if the form is valid, or false if
            // the form is invalid.
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              updateSocialLinks();
            }
          },
          child: Text('Update'),
        ));
  }
}
