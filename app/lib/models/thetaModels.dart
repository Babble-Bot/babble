
class oAuth {
  // "client_id": "nrw8kbwfew3zbyedmyn26ybxu0ixpiue",
  //       "user_id": "usrxhgay62cewzpiymn",
  //       "authorization_code": "fmzi8v3vk7rtkn5p0wex4iz70by65u3a",
  //       "access_token": "npbeddgabtvsmkwv09f7k9etbdx8vew3",
  //       "refresh_token": "p122uwsgjeq20grkhuwm8iptuei3ayc1",
  //       "expires_in": 2591999,
  //       "revoked": false
  final String clientId;
  final String userId;
  final String authCode;
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final bool revoked;

  oAuth({this.clientId, this.userId, this.authCode, this.accessToken, this.refreshToken, this.expiresIn, this.revoked});

  factory oAuth.fromJson(Map<String, dynamic> json) {
    return oAuth(
      clientId: json['clientId'],
      userId: json['userId'],
      authCode: json['authCode'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      expiresIn: json['expiresIn'],
      revoked: json['revoked']
    );
  }
}