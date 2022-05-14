// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

final String followedStores = 'stores';

StoreModel storeModelFromJson(String str) => StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  StoreModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
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
    required this.domain,
    required this.slug,
    required this.gamesCount,
    required this.backgroundImage,
    required this.games,
  });

  int id;
  String name;
  String domain;
  String slug;
  int gamesCount;
  String backgroundImage;
  List<Game> games;

  Result copy({
    int? id,
    String? name,
    String? domain,
    String? slug,
    int? gamesCount,
    String? backgroundImage,
    List<Game>? games
  })=>Result(
      id: id ?? this.id,
      name: name ?? this.name,
      domain: domain ?? this.domain,
      slug: slug ?? this.slug,
      gamesCount: gamesCount ?? this.gamesCount,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      games: games ?? this.games
  );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    domain: json["domain"],
    slug: json["slug"],
    gamesCount: json["games_count"],
    backgroundImage: json["image_background"],
    games: List<Game>.from(json["games"].map((x) => Game.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "domain": domain,
    "slug": slug,
    "games_count": gamesCount,
    "image_background": backgroundImage,
    "games": List<dynamic>.from(games.map((x) => x.toJson())),
  };
}

class StoreFields{
  static final List<String> values =
  [
    name, backgroundImage
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

class StoreOutput{
  StoreOutput({
    required this.name,
    this.backgroundImage
  });
  String name;
  String? backgroundImage;

  factory StoreOutput.fromJson(Map<String, dynamic> json) => StoreOutput(
      name: json['name'],
      backgroundImage: json['backgroundImage']
  );
}