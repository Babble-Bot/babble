
class Config {
  final String subscribeKey;
  final String clientId;
  final String clientSecret;

  Config({this.subscribeKey, this.clientId, this.clientSecret});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      subscribeKey: json["subscribeKey"],
      clientId: json["clientId"],
      clientSecret: json["clientSecret"]
    );
  }
}