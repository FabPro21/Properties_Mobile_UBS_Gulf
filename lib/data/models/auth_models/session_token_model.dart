class SessionTokenModel {
  SessionTokenModel({this.token});

  String token;

  factory SessionTokenModel.fromJson(Map<String, dynamic> json) =>
      SessionTokenModel(token: json["token"]);
}
