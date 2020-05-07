import 'package:flutter/material.dart';
import '../widgets/socialBar.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DashboardStatus createState() => _DashboardStatus();
}

class _DashboardStatus extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This will be the user dash board'),
            SocialBar(),
          ],
        ),
      ),
    );
  }
}