import 'dart:convert';

CredencialModel credencialModelFromJson(String str) =>
    CredencialModel.fromJson(json.decode(str));

String credencialModelToJson(CredencialModel data) =>
    json.encode(data.toJson());

class CredencialModel {
  String? username;
  String? password;
  bool? remember;

  CredencialModel({
    this.username,
    this.password,
    this.remember = false,
  });

  CredencialModel copyWith({
    String? username,
    String? password,
    bool? remember,
  }) {
    return CredencialModel(
      username: username ?? this.username,
      password: password ?? this.password,
      remember: remember ?? this.remember,
    );
  }

  factory CredencialModel.fromJson(Map<String, dynamic> json) =>
      CredencialModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {"username": username, "password": password};

  @override
  String toString() {
    return 'email: $username';
  }
}
