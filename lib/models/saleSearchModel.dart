// To parse this JSON data, do
//
//     final saleSearchModel = saleSearchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SaleSearchModel> saleSearchModelFromJson(String str) => List<SaleSearchModel>.from(json.decode(str).map((x) => SaleSearchModel.fromJson(x)));

String saleSearchModelToJson(List<SaleSearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SaleSearchModel {
  SaleSearchModel({
    required this.gameId,
    required this.steamAppId,
    required this.cheapest,
    required this.cheapestDealId,
    required this.saleSearchModelExternal,
    required this.internalName,
    required this.thumb,
  });

  String gameId;
  String? steamAppId;
  String cheapest;
  String cheapestDealId;
  String saleSearchModelExternal;
  String internalName;
  String thumb;

  factory SaleSearchModel.fromJson(Map<String, dynamic> json) => SaleSearchModel(
    gameId: json["gameID"],
    steamAppId: json["steamAppID"] == null ? null : json["steamAppID"],
    cheapest: json["cheapest"],
    cheapestDealId: json["cheapestDealID"],
    saleSearchModelExternal: json["external"],
    internalName: json["internalName"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "gameID": gameId,
    "steamAppID": steamAppId == null ? null : steamAppId,
    "cheapest": cheapest,
    "cheapestDealID": cheapestDealId,
    "external": saleSearchModelExternal,
    "internalName": internalName,
    "thumb": thumb,
  };
}
