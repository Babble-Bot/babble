

import 'package:babble/models/babble/installs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/dashboad.dart';
import './pages/home.dart';
import './utils/thetaApi.dart';
import './utils/babbleApi.dart';
import './models/theta/auth.dart';
import './models/theta/user.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => Code()),
        FutureProvider<ThetaAuth>(create:(_) => ThetaApi().requestAuth(Code().code)),
        FutureProvider<BabbleInstalls>(create:(_) => BabbleApi().getInstalls()),
      ],
      child:MyApp()
    ),
  );
}

class Code with ChangeNotifier, DiagnosticableTreeMixin {
  String _code = Uri.base.queryParameters['code'] != null ? Uri.base.queryParameters['code'] : "";
  String get code => _code;

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('code', code));
  }
}

class MyApp extends StatelessWidget {
  String code;
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      initialRoute: Code() == "" ? '/dashboard' : '/',
      title: 'Babble',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Babble Bot'),
        '/dashboard': (context) => Dashboard(title: "DashBoard", code: Code().code),
      },
    );
  }
}

