// To parse this JSON data, do
//
//     final exerciseResponse = exerciseResponseFromJson(jsonString);

import 'dart:convert';

ExerciseResponse exerciseResponseFromJson(String str) =>
    ExerciseResponse.fromJson(json.decode(str));

String exerciseResponseToJson(ExerciseResponse data) =>
    json.encode(data.toJson());

class ExerciseResponse {
  ExerciseResponse({
    required this.count,
    required this.samples,
  });

  int count;
  List<Sample> samples;

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) =>
      ExerciseResponse(
        count: json["count"],
        samples:
            List<Sample>.from(json["samples"].map((x) => Sample.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "samples": List<dynamic>.from(samples.map((x) => x.toJson())),
      };
}

class Sample {
  Sample({
    required this.id,
    required this.url,
    required this.score,
    required this.value,
  });

  String id;
  String url;
  int score;
  String value;

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        id: json["_id"],
        url: json["url"],
        score: json["score"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
        "score": score,
        "value": value,
      };
}
