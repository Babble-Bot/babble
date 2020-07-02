import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/babble/channel.dart';
import '../models/babble/installs.dart';

class BabbleApi with ChangeNotifier, DiagnosticableTreeMixin{
  
  Future<BabbleChannel> getChannel(String userId) async {
    var url = 'http://babblechatbot.com/api/theta/channels/' + userId;
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      BabbleChannel channel = BabbleChannel.fromJson(json.decode(response.body));
      notifyListeners();
      return channel;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed get Channel ${response.statusCode}');
    }
  }

  Future<BabbleInstalls> getInstalls() async {
    var url = 'http://babblechatbot.com/api/theta/installs';
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      BabbleInstalls installs = BabbleInstalls.fromJson(json.decode(response.body));
      notifyListeners();
      return installs;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed get Channel ${response.statusCode}');
    }
    
  }
}