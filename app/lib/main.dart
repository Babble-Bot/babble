import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/dashboad.dart';
import './pages/home.dart';
import './utils/thetaApi.dart';
import './utils/babbleApi.dart';
import './models/theta/auth.dart';
import './models/theta/user.dart';
import './models/babble/channel.dart';
import './models/babble/installs.dart';

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
  final ThetaApi thetaApi = ThetaApi();
  final BabbleApi babbleApi = BabbleApi();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Code()),
        ProxyProvider<Code, Future<ThetaAuth>>(
            update: (_, code, __) =>
                (code.code != null) ? thetaApi.requestAuth(code.code) : null),
        ProxyProvider<ThetaAuth, Future<ThetaUser>>(
            update: (_, ThetaAuth thetaAuth, __) => (thetaAuth != null)
                ? thetaApi.getUser(thetaAuth.body.userId)
                : null),
        ProxyProvider<ThetaAuth, Future<BabbleChannel>>(
            update: (_, ThetaAuth thetaAuth, __) => (thetaAuth != null)
                ? babbleApi.getChannel(thetaAuth.body.userId)
                : null),
        FutureProvider(
            create: (_) => BabbleApi().getInstalls(),
            catchError: (_, error) => print(error.toString())),
        // FutureProvider(create: (_) => ThetaApi().requestAuth(Code.code)),
        // FutureProvider(create: (_) => ThetaApi().getUser(thetaApi.userid)),
        // FutureProvider(create: (_) => BabbleApi().getChannel(thetaApi.userid)),
      ],
      child: MaterialApp(
        initialRoute: context.watch<Code>().code != "" ? '/dashboard' : '/',
        title: 'Babble',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => MyHomePage(title: 'Babble Bot'),
          '/dashboard': (context) => Dashboard(title: "DashBoard"),
        },
      ),
    );
  }
}
