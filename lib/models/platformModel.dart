// To parse this JSON data, do
//
//     final platformModel = platformModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PlatformModel platformModelFromJson(String str) => PlatformModel.fromJson(json.decode(str));

String platformModelToJson(PlatformModel data) => json.encode(data.toJson());

class PlatformModel {
  PlatformModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory PlatformModel.fromJson(Map<String, dynamic> json) => PlatformModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
    this.image,
    this.yearStart,
    this.yearEnd,
    required this.games,
  });

  int id;
  String name;
  String slug;
  int gamesCount;
  String imageBackground;
  dynamic? image;
  int? yearStart;
  dynamic? yearEnd;
  List<Game> games;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    imageBackground: json["image_background"],
    image: json["image"],
    yearStart: json["year_start"] == null ? null : json["year_start"],
    yearEnd: json["year_end"],
    games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "games_count": gamesCount,
    "image_background": imageBackground,
    "image": image,
    "year_start": yearStart == null ? null : yearStart,
    "year_end": yearEnd,
    "games": List<dynamic>.from(games.map((x) => x.toJson())),
  };
}

class Game {
  Game({
    required this.id,
    required this.slug,
    required this.name,
    required this.added,
  });

  int id;
  String slug;
  String name;
  int added;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    added: json["added"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "added": added,
  };
}
