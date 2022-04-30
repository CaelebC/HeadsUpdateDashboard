// To parse this JSON data, do
//
//     final freeGameModel = freeGameModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FreeGameModel> freeGameModelFromJson(String str) => List<FreeGameModel>.from(json.decode(str).map((x) => FreeGameModel.fromJson(x)));

String freeGameModelToJson(List<FreeGameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FreeGameModel {
  FreeGameModel({
    required this.id,
    required this.title,
    required this.worth,
    required this.thumbnail,
    required this.image,
    required this.description,
    required this.instructions,
    required this.openGiveawayUrl,
    required this.publishedDate,
    required this.platforms,
    required this.endDate,
  });

  int id;
  String title;
  String worth;
  String thumbnail;
  String image;
  String description;
  String instructions;
  String openGiveawayUrl;
  DateTime publishedDate;
  String platforms;
  String endDate;
  //endDate returns as either a working dateTime (which you need to parse) or as the text "N/\A", when retrieving this data,
  // simply check if the data is "N/\A", and if its not, convert it into a dateTime variable for the UI!

  factory FreeGameModel.fromJson(Map<String, dynamic> json) => FreeGameModel(
    id: json["id"],
    title: json["title"],
    worth: json["worth"],
    thumbnail: json["thumbnail"],
    image: json["image"],
    description: json["description"],
    instructions: json["instructions"],
    openGiveawayUrl: json["open_giveaway_url"],
    publishedDate: DateTime.parse(json["published_date"]),
    platforms: json["platforms"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "worth": worth,
    "thumbnail": thumbnail,
    "image": image,
    "description": description,
    "instructions": instructions,
    "open_giveaway_url": openGiveawayUrl,
    "published_date": publishedDate.toIso8601String(),
    "platforms": platforms,
    "end_date": endDate,
  };
}
