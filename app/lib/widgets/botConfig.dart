import 'package:babble/utils/babbleApi.dart';
import 'package:flutter/material.dart';
import '../models/babble/channel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotConfigCard extends StatefulWidget {
  BotConfigCard({Key key, @required this.channel, this.height, this.width})
      : super(key: key);
  double height;
  double width;
  BabbleChannel channel;

  @override
  _BotConfigCard createState() => _BotConfigCard(channel, height, width);
}

class _BotConfigCard extends State<BotConfigCard> {
  _BotConfigCard(channel, height, width);
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {'prefix': "", 'botName': ""};

  @override
  void initState() {
    super.initState();
    formData['prefix'] = widget.channel.body.prefix;
    formData['botName'] = widget.channel.body.botName;
  }

  Future<void> updateBotConfig() async {
    BabbleApi babbleAip = BabbleApi();
    widget.channel.body.prefix =
        (formData['prefix'] != '') ? formData['prefix'] : "!";
    widget.channel.body.botName =
        (formData['botName'] != '') ? formData['botName'] : "Babble";
    widget.channel = await babbleAip.updateChannel(widget.channel);
    setState(() {
      widget.channel = widget.channel;
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
                  Text("Bot Config"),
                  _prefixInput(),
                  _botNameInput(),
                  _submitButton(),
                ]),
          ),
        ));
  }

  Widget _prefixInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Prefix', hintText: widget.channel.body.prefix),
          onSaved: (val) => setState(() => formData['prefix'] = val),
        ));
  }

  Widget _botNameInput() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Bot Name', hintText: widget.channel.body.botName),
          onSaved: (val) => setState(() => formData['botName'] = val),
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
              updateBotConfig();
            }
          },
          child: Text('Update'),
        ));
  }
}
