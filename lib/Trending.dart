// To parse this JSON data, do
//
//     final pilem = pilemFromJson(jsonString);

import 'dart:convert';

Pilem pilemFromJson(String str) => Pilem.fromJson(json.decode(str));

String pilemToJson(Pilem data) => json.encode(data.toJson());

class Pilem {
  Pilem({
    this.result,
    this.page,
  });

  List<Result> result;
  int page;

  factory Pilem.fromJson(Map<String, dynamic> json) => Pilem(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "page": page,
  };
}

class Result {
  Result({
    this.title,
    this.thumbnail,
    this.genre,
    this.rating,
    this.duration,
    this.quality,
    this.trailer,
    this.watch,
  });

  String title;
  String thumbnail;
  List<String> genre;
  String rating;
  String duration;
  Quality quality;
  String trailer;
  String watch;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    thumbnail: json["thumbnail"],
    genre: List<String>.from(json["genre"].map((x) => x)),
    rating: json["rating"],
    duration: json["duration"],
    quality: qualityValues.map[json["quality"]],
    trailer: json["trailer"],
    watch: json["watch"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "thumbnail": thumbnail,
    "genre": List<dynamic>.from(genre.map((x) => x)),
    "rating": rating,
    "duration": duration,
    "quality": qualityValues.reverse[quality],
    "trailer": trailer,
    "watch": watch,
  };
}

enum Quality { HD }

final qualityValues = EnumValues({
  "HD": Quality.HD
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
