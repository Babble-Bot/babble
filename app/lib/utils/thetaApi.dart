import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/theta/auth.dart';
import '../models/theta/user.dart';

class ThetaApi with ChangeNotifier, DiagnosticableTreeMixin {
  ThetaAuth thetaAuth;
  ThetaUser thetaUser;

  Future<ThetaAuth> requestAuth(String code) async {
    var url = 'https://api.theta.tv/v1/oauth/token?client_id=nrw8kbwfew3zbyedmyn26ybxu0ixpiue&client_secret=pb6aesq10kqsebp3ztxz1cn7hgztegvr&grant_type=authorization_code&code=' + code;
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      thetaAuth = ThetaAuth.fromJson(json.decode(response.body));
      return thetaAuth;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login with Theta ${response.statusCode}');
    }
  }

  Future<ThetaUser> getUser(String userId) async {
    var url = 'https://api.theta.tv/v1/user/' + userId;
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      thetaUser = ThetaUser.fromJson(json.decode(response.body));
      return thetaUser;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login with Theta ${response.statusCode}');
    }
  }

  //https://api.flutter.dev/flutter/foundation/DiagnosticableTreeMixin/debugFillProperties.html
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add();
  // }
}


