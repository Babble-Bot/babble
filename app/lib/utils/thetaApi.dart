import 'package:http/http.dart' as http;
import '../models/ThetaAuth.dart';

class ThetaApi {
  Future<ThetaAuth> requestThetaAuth(String code) async {
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
      return ThetaAuth.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login with Theta ${response.statusCode}');
    }
  }
}


