import 'dart:convert';

AuthReq authReqFromJson(String str) => AuthReq.fromJson(json.decode(str));

String authReqToJson(AuthReq data) => json.encode(data.toJson());

class AuthReq {
  AuthReq({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  factory AuthReq.fromJson(Map<String, dynamic> json) => AuthReq(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
