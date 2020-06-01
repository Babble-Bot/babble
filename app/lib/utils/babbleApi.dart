import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/babble-channel.dart';

class BabbleApi {

  Future<BabbleChannel> getChannel(String userId) async {
    var url = 'http://localhost/api/theta/channels/' + userId;
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      BabbleChannel channel = BabbleChannel.fromJson(json.decode(response.body));
      return channel;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to login with Theta ${response.statusCode}');
    }
  }
}