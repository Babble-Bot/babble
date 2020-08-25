import 'package:babble/models/babble/installs.dart';
import 'package:babble/utils/babbleApi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/socialBar.dart';
import '../widgets/statusBar.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final BabbleApi babbleApi = BabbleApi();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureProvider(
                        create: (_) => babbleApi.getInstalls(),
                        child: Consumer<BabbleInstalls>(builder:
                            (context, BabbleInstalls installs, widget) {
                          return (installs != null)
                              ? StatusBar(installs: installs)
                              : CircularProgressIndicator(
                                  backgroundColor: Colors.lightBlue);
                        }))
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Welcome to Babble'),
                    Image.asset(
                      'assets/babble.png',
                      scale: 10,
                      fit: BoxFit.cover,
                    ),
                    RaisedButton(
                      child: Text('Login With Theta'),
                      color: Colors.white,
                      onPressed: () async {
                        String url =
                            'https://www.theta.tv/account/grant-app?client_id=nrw8kbwfew3zbyedmyn26ybxu0ixpiue&redirect_uri=http://babblechatbot.com/';
                        await launch(url,
                            forceSafariVC: false,
                            forceWebView: true,
                            enableJavaScript: true);
                      },
                    ),
                  ],
                )
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    SocialBar(),
                  ])
                ],
              ),
            ])
          ],
        ),
      ),
    );
  }
}
