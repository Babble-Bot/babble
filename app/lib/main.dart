import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/dashboad.dart';
import './pages/home.dart';

void main() => runApp(MyApp());

class Code with ChangeNotifier, DiagnosticableTreeMixin {
  String _code = Uri.base.queryParameters['code'] != null
      ? Uri.base.queryParameters['code']
      : "";
  String get code => _code;

  notifyListeners();

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('code', code));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Code()),
        ],
        child: Consumer<Code>(builder: (context, code, __) {
          return MaterialApp(
            initialRoute: (code.code != "") ? '/dashboard' : '/',
            title: 'Babble',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              '/': (context) => MyHomePage(title: 'Babble Bot'),
              '/dashboard': (context) => Dashboard(code: code.code),
            },
          );
        }));
  }
}
