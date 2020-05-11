import 'package:http/http.dart' as http;
import '../models/thetaModels.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ThetaApi {
  void auth(String code) async {
  var url = 'https://api.theta.tv/v1/oauth/token?client_id=nrw8kbwfew3zbyedmyn26ybxu0ixpiue&client_secret=pb6aesq10kqsebp3ztxz1cn7hgztegvr&grant_type=authorization_code&code='+code;

    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print('json: $jsonResponse.');
      //Navigator.pushNamed(context, '/dashboard');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}


