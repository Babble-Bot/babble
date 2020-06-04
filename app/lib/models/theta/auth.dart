class ThetaAuth {
  String status;
  Body body;

  ThetaAuth({this.status, this.body});

  ThetaAuth.fromJson(Map<String, dynamic> json) {
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
  String clientId;
  String userId;
  String authorizationCode;
  String accessToken;
  String refreshToken;
  int expiresIn;
  bool revoked;

  Body(
      {this.clientId,
      this.userId,
      this.authorizationCode,
      this.accessToken,
      this.refreshToken,
      this.expiresIn,
      this.revoked});

  Body.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    userId = json['user_id'];
    authorizationCode = json['authorization_code'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    revoked = json['revoked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['user_id'] = this.userId;
    data['authorization_code'] = this.authorizationCode;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    data['revoked'] = this.revoked;
    return data;
  }
}
