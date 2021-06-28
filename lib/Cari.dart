// To parse this JSON data, do
//
//     final cari = cariFromJson(jsonString);

import 'dart:convert';

List<Cari> cariFromJson(String str) => List<Cari>.from(json.decode(str).map((x) => Cari.fromJson(x)));

String cariToJson(List<Cari> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cari {
  Cari({
    this.id,
    this.title,
    this.rating,
    this.duration,
    this.waktu,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String rating;
  String duration;
  String waktu;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  factory Cari.fromJson(Map<String, dynamic> json) => Cari(
    id: json["id"],
    title: json["title"],
    rating: json["rating"],
    duration: json["duration"],
    waktu: json["waktu"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "rating": rating,
    "duration": duration,
    "waktu": waktu,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

