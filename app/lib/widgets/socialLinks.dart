import 'package:babble/utils/babbleApi.dart';
import 'package:flutter/material.dart';
import '../models/babble/channel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLinksCard extends StatefulWidget {
  SocialLinksCard(
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
  _SocialLinksCard createState() =>
      _SocialLinksCard(config, channel, height, width);
}

class _SocialLinksCard extends State<SocialLinksCard> {
  _SocialLinksCard(config, channel, height, width);
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {
    'twitter': "",
    'twitch': "",
    'youtube': "",
    'discord': "",
    'instagram': "",
    'facebook': "",
    'snapchat': "",
    'tiktok': ""
  };

  @override
  void initState() {
    super.initState();
    formData['twitter'] = widget.config.twitter;
    formData['twitch'] = widget.config.twitch;
    formData['youtube'] = widget.config.youtube;
    formData['discord'] = widget.config.discord;
    formData['instagram'] = widget.config.instagram;
    formData['facebook'] = widget.config.facebook;
    formData['snapchat'] = widget.config.snapchat;
    formData['tiktok'] = widget.config.tiktok;
  }

  Future<void> updateSocialLinks() async {
    BabbleApi babbleAip = BabbleApi();
    widget.channel.body.socialLinks.twitter = formData['twitter'];
    widget.channel.body.socialLinks.twitch = formData['twitch'];
    widget.channel.body.socialLinks.youtube = formData['youtube'];
    widget.channel.body.socialLinks.discord = formData['discord'];
    widget.channel.body.socialLinks.instagram = formData['instagram'];
    widget.channel.body.socialLinks.facebook = formData['facebook'];
    widget.channel.body.socialLinks.snapchat = formData['snapchat'];
    widget.channel.body.socialLinks.tiktok = formData['tiktok'];
    widget.channel = await babbleAip.updateChannel(widget.channel);
    setState(() {
      widget.config = widget.channel.body.socialLinks;
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
                  _instagramInput(),
                  _facebookInput(),
                  _snapchatInput(),
                  _tiktokInput(),
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

  Widget _instagramInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: FaIcon(FontAwesomeIcons.instagram,
                  color: Color.fromARGB(255, 0, 0, 0)),
              labelText: 'Instagram',
              hintText: widget.config.instagram),
          onSaved: (val) => setState(() => formData['instagram'] = val),
        ));
  }

  Widget _facebookInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: FaIcon(FontAwesomeIcons.facebook,
                  color: Color.fromARGB(255, 67, 96, 156)),
              labelText: 'Facebook',
              hintText: widget.config.facebook),
          onSaved: (val) => setState(() => formData['facebook'] = val),
        ));
  }

  Widget _snapchatInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              icon: FaIcon(FontAwesomeIcons.snapchat,
                  color: Color.fromARGB(255, 255, 252, 0)),
              labelText: 'Snapchat',
              hintText: widget.config.snapchat),
          onSaved: (val) => setState(() => formData['snapchat'] = val),
        ));
  }

  Widget _tiktokInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'TikTok', hintText: widget.config.tiktok),
          onSaved: (val) => setState(() => formData['tiktok'] = val),
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
