// To parse this JSON data, do
//
//     final platformModel = platformModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

final String followedPlatforms = 'platforms';
final String platformGames = 'games';

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
    required this.backgroundImage,
    this.image,
    this.yearStart,
    this.yearEnd,
    required this.games,
  });

  int id;
  String name;
  String slug;
  int gamesCount;
  String backgroundImage;
  dynamic? image;
  int? yearStart;
  dynamic? yearEnd;
  List<Game> games;

  Result copy({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    String? backgroundImage,
    dynamic? image,
    int? yearStart,
    dynamic? yearEnd,
    List<Game>? games,
  })=>Result(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    gamesCount: gamesCount ?? this.gamesCount,
    backgroundImage: backgroundImage ?? this.backgroundImage,
    image: image ?? this.image,
    yearStart: yearStart ?? this.yearStart,
    yearEnd: yearEnd ?? this.yearEnd,
    games: games ?? this.games
  );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    backgroundImage: json["image_background"],
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
    "image_background": backgroundImage,
    "image": image,
    "year_start": yearStart == null ? null : yearStart,
    "year_end": yearEnd,
    "games": List<dynamic>.from(games.map((x) => x.toJson())),
  };
}

class PlatformFields{
  static final List<String> values =
      [
        name, backgroundImage,
      ];
  static final String name = 'name';
  static final String backgroundImage = 'backgroundImage';
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

class PlatformOutput{
  PlatformOutput({
    required this.name,
    this.backgroundImage
  });
  String name;
  String? backgroundImage;

  factory PlatformOutput.fromJson(Map<String, dynamic> json) => PlatformOutput(
      name: json['name'],
      backgroundImage: json['backgorundImage']
  );
}