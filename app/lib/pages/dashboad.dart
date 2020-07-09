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

class Dashboard extends StatelessWidget {
  Dashboard({@required this.code});
  final String code;

  @override
  Widget build(BuildContext context) {
    final ThetaApi thetaApi = ThetaApi();
    final BabbleApi babbleApi = BabbleApi();
    return FutureProvider(
        create: (_) => thetaApi.requestAuth(code),
        child: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Consumer<ThetaAuth>(
                    builder: (context, ThetaAuth auth, widget) {
                  return (auth != null)
                      ? FutureProvider(
                          create: (_) => thetaApi.getUser(auth.body.userId),
                          child: Consumer<ThetaUser>(
                              builder: (_, ThetaUser thetaUser, __) {
                            return (thetaUser != null)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(thetaUser.body.username),
                                      Container(
                                          width: 32,
                                          height: 32,
                                          padding: EdgeInsets.fromLTRB(
                                              20.0, 0, 0, 0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(thetaUser
                                                      .body.avatarUrl)))),
                                    ],
                                  )
                                : Text("Dashboard");
                          }))
                      : Text("Dashboard");
                })),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Consumer<ThetaAuth>(
                    builder: (context, ThetaAuth auth, widget) {
                  return (auth != null)
                      ? FutureProvider(
                          create: (_) => babbleApi.getChannel(auth.body.userId),
                          child: Consumer<BabbleChannel>(builder:
                              (context, BabbleChannel channel, widget) {
                            return (channel != null)
                                ? Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        AlertConfigCard(
                                            config: channel.body.alertConfig,
                                            channel: channel,
                                            width: 300),
                                        SocialLinksCard(
                                            config: channel.body.socialLinks,
                                            width: 300)
                                      ],
                                    ),
                                    SocialBar(),
                                  ])
                                : Column(children: <Widget>[
                                    CircularProgressIndicator(
                                        backgroundColor: Colors.lightBlue),
                                    SocialBar()
                                  ]);
                          }))
                      : Column(children: <Widget>[
                          CircularProgressIndicator(
                              backgroundColor: Colors.lightBlue),
                          SocialBar()
                        ]);
                }),
              ),
            )));
  }
}
