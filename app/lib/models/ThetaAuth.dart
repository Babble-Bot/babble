class ThetaAuth {
  String clientId;
  String userId;
  String authorizationCode;
  String accessToken;
  String refreshToken;
  int expiresIn;
  bool revoked;

  ThetaAuth(
      {this.clientId,
      this.userId,
      this.authorizationCode,
      this.accessToken,
      this.refreshToken,
      this.expiresIn,
      this.revoked});

  ThetaAuth.fromJson(Map<String, dynamic> json) {
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
