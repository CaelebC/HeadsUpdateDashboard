// To parse this JSON data, do:
//
//     final gameModel = gameModelFromJson(jsonString);


//NOTE: This gameModel is not 1:1 exact with the jSON data thats being received,
//some fields were cut to try and combat flutter null safet,y but you can def just
// refresh this with all the original complete fields if that begins causing problems.

import 'package:meta/meta.dart';
import 'dart:convert';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class GameModel {
    GameModel({
        required this.count,
        required this.results,
        required this.userPlatforms,
    });

    int count;
    List<Result> results;
    bool userPlatforms;

    factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        count: json["count"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        userPlatforms: json["user_platforms"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "user_platforms": userPlatforms,
    };
}

class Result {
    Result({
        required this.slug,
        required this.name,
        required this.platforms,
        required this.stores,
        required this.released,
        required this.tba,
        required this.backgroundImage,
        required this.rating,
        required this.parentPlatforms,
        required this.genres,
    });

    String slug;
    String name;
    List<Platform> platforms;
    List<Store> stores;
    DateTime released;
    bool tba;
    String backgroundImage;
    double rating;
    List<Platform> parentPlatforms;
    List<Genre> genres;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        slug: json["slug"],
        name: json["name"],
        platforms: List<Platform>.from(json["platforms"].map((x) => Platform.fromJson(x))),
        stores: List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
        released: DateTime.parse(json["released"]),
        tba: json["tba"],
        backgroundImage: json["background_image"],
        rating: json["rating"].toDouble(),
        parentPlatforms: List<Platform>.from(json["parent_platforms"].map((x) => Platform.fromJson(x))),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "platforms": List<dynamic>.from(platforms.map((x) => x.toJson())),
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
        "released": "${released.year.toString().padLeft(4, '0')}-${released.month.toString().padLeft(2, '0')}-${released.day.toString().padLeft(2, '0')}",
        "tba": tba,
        "background_image": backgroundImage,
        "rating": rating,
        "parent_platforms": List<dynamic>.from(parentPlatforms.map((x) => x.toJson())),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class Genre {
    Genre({
        required this.id,
        required this.name,
        required this.slug,
    });

    int id;
    String name;
    String slug;

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
    };
}

class Platform {
    Platform({
        required this.platform,
    });

    Genre platform;

    factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        platform: Genre.fromJson(json["platform"]),
    );

    Map<String, dynamic> toJson() => {
        "platform": platform.toJson(),
    };
}

class Store {
    Store({
        required this.store,
    });

    Genre store;

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        store: Genre.fromJson(json["store"]),
    );

    Map<String, dynamic> toJson() => {
        "store": store.toJson(),
    };
}
