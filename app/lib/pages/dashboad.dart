
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/socialBar.dart';
import '../widgets/alertConfig.dart';
import '../widgets/socialLinks.dart';
import '../models/theta/auth.dart';
import '../models/theta/user.dart';
import '../models/babble/channel.dart';
import '../utils/thetaApi.dart';
import '../utils/babbleApi.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DashboardStatus createState() => _DashboardStatus();
}

class _DashboardStatus extends State<Dashboard> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Future<ThetaAuth>>(context);
    final channel = Provider.of<Future<BabbleChannel>>(context);
    final thetaUser = Provider.of<Future<ThetaUser>>(context);
    return FutureProvider(
      create: (_) => auth,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: (auth != null) ?
          FutureProvider(
            create: (_) => thetaUser,
            child: (thetaUser != null) ? Consumer<ThetaUser>(
              builder: (_, ThetaUser thetaUser, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(thetaUser.body.username),
                    Container(
                      width: 32,
                      height: 32,
                      padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(thetaUser.body.avatarUrl)
                          )
                      )
                    ),
                  ],
                );
              }
            ): Text(widget.title),
          ): Text(widget.title),
        ),
        body:
          Column(
            children: <Widget>[
              (auth != null) ? FutureProvider(
                create: (_) => channel,
                child: (channel != null) ? Consumer<BabbleChannel>(
                  builder: (_, BabbleChannel babbleChannel, __){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AlertConfigCard(config: babbleChannel.body.alertConfig, width: 300),
                            SocialLinksCard(config: babbleChannel.body.alertConfig, width: 300)
                          ],
                        )
                      ]
                    );
                  }
                )
                : Text("Loading"),
              ) : Text("Loading"),
                CircularProgressIndicator(
                  backgroundColor: Colors.lightBlue,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SocialBar()
                  ]
                )
            ],
          )
      )
    );
  }
}