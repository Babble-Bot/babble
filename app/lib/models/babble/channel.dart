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
  String botName;
  AlertConfig alertConfig;
  SocialLinks socialLinks;
  BridgeConfig bridgeConfig;
  List<CustomCmds> customCmds;

  Body(
      {this.clientId,
      this.userId,
      this.accessToken,
      this.prefix,
      this.botName,
      this.alertConfig,
      this.socialLinks,
      this.bridgeConfig,
      this.customCmds});

  Body.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    userId = json['userId'];
    accessToken = json['accessToken'];
    prefix = json['prefix'];
    botName = json['botName'];
    alertConfig = json['alertConfig'] != null
        ? new AlertConfig.fromJson(json['alertConfig'])
        : null;
    socialLinks = json['socialLinks'] != null
        ? new SocialLinks.fromJson(json['socialLinks'])
        : null;
    bridgeConfig = json['bridgeConfig'] != null
        ? new BridgeConfig.fromJson(json['bridgeConfig'])
        : null;
    if (json['customCmds'] != null) {
      customCmds = new List<CustomCmds>();
      json['customCmds'].forEach((v) {
        customCmds.add(new CustomCmds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['userId'] = this.userId;
    data['accessToken'] = this.accessToken;
    data['prefix'] = this.prefix;
    data['botName'] = this.botName;
    if (this.alertConfig != null) {
      data['alertConfig'] = this.alertConfig.toJson();
    }
    if (this.socialLinks != null) {
      data['socialLinks'] = this.socialLinks.toJson();
    }
    if (this.bridgeConfig != null) {
      data['bridgeConfig'] = this.bridgeConfig.toJson();
    }
    if (this.customCmds != null) {
      data['customCmds'] = this.customCmds.map((v) => v.toJson()).toList();
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

class SocialLinks {
  String twitter;
  String twitch;
  String youtube;
  String discord;
  String instagram;
  String facebook;
  String snapchat;
  String tiktok;

  SocialLinks(
      {this.twitter,
      this.twitch,
      this.youtube,
      this.discord,
      this.instagram,
      this.facebook,
      this.snapchat,
      this.tiktok});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    twitter = json['twitter'];
    twitch = json['twitch'];
    youtube = json['youtube'];
    discord = json['discord'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['twitter'] = this.twitter;
    data['twitch'] = this.twitch;
    data['youtube'] = this.youtube;
    data['discord'] = this.discord;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['snapchat'] = this.snapchat;
    data['tiktok'] = this.tiktok;
    return data;
  }
}

class BridgeConfig {
  ThetaConfig thetaConfig;
  ThetaConfig twitchConfig;

  BridgeConfig({this.thetaConfig, this.twitchConfig});

  BridgeConfig.fromJson(Map<String, dynamic> json) {
    thetaConfig = json['thetaConfig'] != null
        ? new ThetaConfig.fromJson(json['thetaConfig'])
        : null;
    twitchConfig = json['twitchConfig'] != null
        ? new ThetaConfig.fromJson(json['twitchConfig'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thetaConfig != null) {
      data['thetaConfig'] = this.thetaConfig.toJson();
    }
    if (this.twitchConfig != null) {
      data['twitchConfig'] = this.twitchConfig.toJson();
    }
    return data;
  }
}

class ThetaConfig {
  String active;
  String channelId;

  ThetaConfig({this.active, this.channelId});

  ThetaConfig.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    channelId = json['channelId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['channelId'] = this.channelId;
    return data;
  }
}

class CustomCmds {
  String name;
  String message;

  CustomCmds({this.name, this.message});

  CustomCmds.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['message'] = this.message;
    return data;
  }
}
