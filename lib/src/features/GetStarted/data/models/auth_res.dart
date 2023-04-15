// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    required this.message,
    required this.docs,
  });

  String message;
  List<Doc> docs;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        message: json["message"],
        docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
      };
}

class Doc {
  Doc({
    required this.id,
    required this.password,
    required this.email,
    required this.score,
    required this.completed,
    required this.v,
  });

  String id;
  String password;
  String email;
  int score;
  List<dynamic> completed;
  int v;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        password: json["password"],
        email: json["email"],
        score: json["score"],
        completed: List<dynamic>.from(json["completed"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "password": password,
        "email": email,
        "score": score,
        "completed": List<dynamic>.from(completed.map((x) => x)),
        "__v": v,
      };
}
