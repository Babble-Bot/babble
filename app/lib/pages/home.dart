import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    String code = Uri.base.queryParameters['code'];

    if(code != ""){
      
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to Babble'),
            Image.asset('assets/babble.png',scale:10,fit: BoxFit.cover,),
            Text('My Devs are working hard to get me up and running. in the mean time you can find me here:' + code),
            Row(
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
            ),
          ],
        ),
      ),
    );
  }
}