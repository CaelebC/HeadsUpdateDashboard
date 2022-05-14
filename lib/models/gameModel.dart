// To parse this JSON data, do:
//
//     final gameModel = gameModelFromJson(jsonString);


//NOTE: This gameModel is not 1:1 exact with the jSON data thats being received,
//some fields were cut to try and combat flutter null safet,y but you can def just
// refresh this with all the original complete fields if that begins causing problems.

import 'package:meta/meta.dart';
import 'dart:convert';

final String followedGames = 'games';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class GameModel {
    GameModel({
        required this.count,
        required this.results,
    });

    int count;
    List<Result> results;

    factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        count: json["count"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.slug,
        required this.name,
        required this.platforms,
        this.stores,
        //this.released,
        required this.tba,
        required this.backgroundImage,
        required this.rating,
        required this.parentPlatforms,
        required this.genres,
    });

    String slug;
    String name;
    List<Platform> platforms;
    List<Store>? stores;
    //DateTime? released;
    bool tba;
    String backgroundImage;
    double rating;
    List<Platform> parentPlatforms;
    List<Genre> genres;

    Result copy({
        String? slug,
        String? name,
        List<Platform>? platforms,
        List<Store>? stores,
        //DateTime? released,
        bool? tba,
        String? backgroundImage,
        double? rating,
        List<Platform>? parentPlatforms,
        List<Genre>? genres
    })=>Result(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        platforms: platforms ?? this.platforms,
        stores: stores ?? this.stores,
        //released: released ?? this.released,
        tba: tba ?? this.tba,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        rating: rating ?? this.rating,
        parentPlatforms: parentPlatforms ?? this.parentPlatforms,
        genres: genres ?? this.genres,
    );

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        slug: json["slug"],
        name: json["name"],
        platforms: List<Platform>.from(json["platforms"].map((x) => Platform.fromJson(x))),
        stores: json["stores"] == null ? null : List<Store>.from(json["stores"].map((x) => Store.fromJson(x))),
        //released: json["released"] == null ? null : DateTime.parse(json["released"]),
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
        "stores": stores == null ? null : List<dynamic>.from(stores!.map((x) => x.toJson())),
       // "released": released == null ? null : "${released.year.toString().padLeft(4, '0')}-${released.month.toString().padLeft(2, '0')}-${released.day.toString().padLeft(2, '0')}",
        "tba": tba,
        "background_image": backgroundImage,
        "rating": rating,
        "parent_platforms": List<dynamic>.from(parentPlatforms.map((x) => x.toJson())),
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    };
}

class GameFields {
    static final List<String> values =
    [
        name, backgroundImage,
        genres, platforms, stores
    ];

    static final String name = 'name';
    static final String backgroundImage = 'backgroundImage';
    static final String genres = 'genres';
    static final String platforms = 'platforms';
    static final String stores = 'stores';
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

    Genre copy({
        int? id,
        String? name,
        String? slug
    })=>Genre(
        id: id ?? this.id,
        name : name ?? this.name,
        slug: slug ?? this.slug
    );

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

    //incredibly unsure of this
    Platform copy({
        Genre? platform
    })=>Platform(
        platform: platform ?? this.platform
    );

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

    //??????
    Store copy({
        Genre? store
    })=>Store(
        store: store ?? this.store
    );

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        store: Genre.fromJson(json["store"]),
    );

    Map<String, dynamic> toJson() => {
        "store": store.toJson(),
    };
}

class GameOutput{
    GameOutput({
        required this.name,
        required this.backgroundImage,
        required this.genres,
        required this.platforms,
        required this.stores
    });
    String name;
    String? backgroundImage;
    String? genres;
    String? platforms;
    String? stores;

    factory GameOutput.fromJson(Map<String, dynamic> json) => GameOutput(
        name: json["name"],
        backgroundImage: json["backgroundImage"],
        genres: json["genres"],
        platforms: json["platforms"],
        stores: json["stores"],
    );
}