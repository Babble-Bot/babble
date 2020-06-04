class ThetaUser {
  String status;
  Body body;

  ThetaUser({this.status, this.body});

  ThetaUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    return data;
  }
}

class Body {
  int creationTimestamp;
  String country;
  String twitchLogin;
  String id;
  String username;
  String type;
  String channelDescription;
  String gender;
  List<String> preferredGames;
  String avatarUrl;
  int subscriberCount;
  int subscriptionCount;
  int uploadedCount;

  Body(
      {this.creationTimestamp,
      this.country,
      this.twitchLogin,
      this.id,
      this.username,
      this.type,
      this.channelDescription,
      this.gender,
      this.preferredGames,
      this.avatarUrl,
      this.subscriberCount,
      this.subscriptionCount,
      this.uploadedCount});

  Body.fromJson(Map<String, dynamic> json) {
    creationTimestamp = json['creation_timestamp'];
    country = json['country'];
    twitchLogin = json['twitch_login'];
    id = json['id'];
    username = json['username'];
    type = json['type'];
    channelDescription = json['channel_description'];
    gender = json['gender'];
    if (json['preferred_games'] != null) {
      preferredGames = new List<String>();
      json['preferred_games'].forEach((v) {
        preferredGames.add(v);
      });
    }
    avatarUrl = json['avatar_url'];
    subscriberCount = json['subscriber_count'];
    subscriptionCount = json['subscription_count'];
    uploadedCount = json['uploaded_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creation_timestamp'] = this.creationTimestamp;
    data['country'] = this.country;
    data['twitch_login'] = this.twitchLogin;
    data['id'] = this.id;
    data['username'] = this.username;
    data['type'] = this.type;
    data['channel_description'] = this.channelDescription;
    data['gender'] = this.gender;
    if (this.preferredGames != null) {
      data['preferred_games'] =
          this.preferredGames.map((v) => v).toList();
    }
    data['avatar_url'] = this.avatarUrl;
    data['subscriber_count'] = this.subscriberCount;
    data['subscription_count'] = this.subscriptionCount;
    data['uploaded_count'] = this.uploadedCount;
    return data;
  }
}
