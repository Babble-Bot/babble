class BabbleInstalls {
  Body body;
  int status;

  BabbleInstalls({this.body, this.status});

  BabbleInstalls.fromJson(Map<String, dynamic> json) {
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
  int theta;
  int twitch;

  Body({this.theta, this.twitch});

  Body.fromJson(Map<String, dynamic> json) {
    theta = json['theta'];
    twitch = json['twitch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['theta'] = this.theta;
    data['twitch'] = this.twitch;
    return data;
  }
}
