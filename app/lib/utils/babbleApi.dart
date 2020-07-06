import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/babble/channel.dart';
import '../models/babble/installs.dart';

class BabbleApi with ChangeNotifier, DiagnosticableTreeMixin {
  Future<BabbleChannel> getChannel(String userId) async {
    var url = 'http://babblechatbot.com/api/theta/channels/' + userId;
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      BabbleChannel channel =
          BabbleChannel.fromJson(json.decode(response.body));
      notifyListeners();
      return channel;
    } else {
      throw Exception('Failed get Channel ${response.statusCode}');
    }
  }

  Future<BabbleInstalls> getInstalls() async {
    var url = 'http://babblechatbot.com/api/theta/installs';
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      BabbleInstalls installs =
          BabbleInstalls.fromJson(json.decode(response.body));
      notifyListeners();
      return installs;
    } else {
      throw Exception('Failed get Channel ${response.statusCode}');
    }
  }

  Future<BabbleChannel> updateChannel(BabbleChannel updatedChannel) async {
    var url = 'http://babblechatbot.com/api/theta/channel/' +
        updatedChannel.body.userId;
    var body = json.encode(updatedChannel.body);
    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      BabbleChannel channel =
          BabbleChannel.fromJson(json.decode(response.body));
      notifyListeners();
      return channel;
    } else {
      throw Exception('Failed get Channel ${response.statusCode}');
    }
  }
}
