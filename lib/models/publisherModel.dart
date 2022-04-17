// To parse this JSON data, do
//
//     final publisherModel = publisherModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

final String followedPublishers = 'publishers';

PublisherModel publisherModelFromJson(String str) => PublisherModel.fromJson(json.decode(str));

String publisherModelToJson(PublisherModel data) => json.encode(data.toJson());

class PublisherModel {
  PublisherModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String? next;
  dynamic? previous;
  List<Result> results;

  factory PublisherModel.fromJson(Map<String, dynamic> json) => PublisherModel(
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
    required this.games,
  });

  int id;
  String name;
  String slug;
  int gamesCount;
  String imageBackground;
  List<Game> games;

  Result copy({
    int? id,
    String? name,
    String? slug,
    int? gamesCount,
    String? imageBackground,
    List<Game>? games
  })=>Result(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      gamesCount: gamesCount ?? this.gamesCount,
      imageBackground: imageBackground ?? this.imageBackground,
      games: games ?? this.games
  );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    imageBackground: json["image_background"],
    games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "games_count": gamesCount,
    "image_background": imageBackground,
    "games": List<dynamic>.from(games.map((x) => x.toJson())),
  };
}

class PublisherFields{
  static final List<String> values =
  [
    id, name, slug,
    gamesCount, imageBackground, games
  ];
  static final String id = '_id';
  static final String name = 'name';
  static final String slug = 'slug';
  static final String gamesCount = 'gamesCount';
  static final String imageBackground = 'imageBackground';
  static final String games = 'games';
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
