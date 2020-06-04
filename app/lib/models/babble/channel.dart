class BabbleChannel {
  Body body;
  int status;

  BabbleChannel({this.body, this.status});

  BabbleChannel.fromJson(Map<String, dynamic> json) {
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.body != null) {
      data['body'] = this.body.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Body {
  String clientId;
  String userId;
  String accessToken;
  String prefix;
  AlertConfig alertConfig;

  Body(
      {this.clientId,
      this.userId,
      this.accessToken,
      this.prefix,
      this.alertConfig});

  Body.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    userId = json['userId'];
    accessToken = json['accessToken'];
    prefix = json['prefix'];
    alertConfig = json['alertConfig'] != null
        ? new AlertConfig.fromJson(json['alertConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['userId'] = this.userId;
    data['accessToken'] = this.accessToken;
    data['prefix'] = this.prefix;
    if (this.alertConfig != null) {
      data['alertConfig'] = this.alertConfig.toJson();
    }
    return data;
  }
}

class AlertConfig {
  bool all;
  bool hello;
  bool donation;
  bool follow;
  bool gift;
  bool sub;
  bool giftedsub;
  bool level;
  bool quiz;
  bool raffle;
  bool rafflewin;

  AlertConfig(
      {this.all,
      this.hello,
      this.donation,
      this.follow,
      this.gift,
      this.sub,
      this.giftedsub,
      this.level,
      this.quiz,
      this.raffle,
      this.rafflewin});

  AlertConfig.fromJson(Map<String, dynamic> json) {
    all = json['all'];
    hello = json['hello'];
    donation = json['donation'];
    follow = json['follow'];
    gift = json['gift'];
    sub = json['sub'];
    giftedsub = json['giftedsub'];
    level = json['level'];
    quiz = json['quiz'];
    raffle = json['raffle'];
    rafflewin = json['rafflewin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    data['hello'] = this.hello;
    data['donation'] = this.donation;
    data['follow'] = this.follow;
    data['gift'] = this.gift;
    data['sub'] = this.sub;
    data['giftedsub'] = this.giftedsub;
    data['level'] = this.level;
    data['quiz'] = this.quiz;
    data['raffle'] = this.raffle;
    data['rafflewin'] = this.rafflewin;
    return data;
  }
}
