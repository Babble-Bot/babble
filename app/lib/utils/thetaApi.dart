import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/thetaModels.dart';
import '../models/config.dart';

final List<Config> _config = List<Config>.from(jsonDecode('assets/config.json') as List);


Future<oAuth> requestAuthToken(String title) async {

  final http.Response response = await http.post(
    'https://api.theta.tv/v1/oauth/token?client_id=nrw8kbwfew3zbyedmyn26ybxu0ixpiue&client_secret=pb6aesq10kqsebp3ztxz1cn7hgztegvr&grant_type=authorization_code&code=fmzi8v3vk7rtkn5p0wex4iz70by65u3a',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return oAuth.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



