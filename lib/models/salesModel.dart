// To parse this JSON data, do
//
//     final salesModel = salesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SalesModel> salesModelFromJson(String str) => List<SalesModel>.from(json.decode(str).map((x) => SalesModel.fromJson(x)));

String salesModelToJson(List<SalesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SalesModel {
  SalesModel({
    required this.title,
    required this.dealId,
    required this.salePrice,
    required this.normalPrice,
    required this.savings,
    required this.releaseDate,
    required this.lastChange,
    required this.dealRating,
    required this.thumb,
  });

  String title;
  String dealId;
  String salePrice;
  String normalPrice;
  String savings;
  int releaseDate;
  int lastChange;
  String dealRating;
  String thumb;

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(

    title: json["title"],
    dealId: json["dealID"],
    salePrice: json["salePrice"],
    normalPrice: json["normalPrice"],
    savings: json["savings"],
    releaseDate: json["releaseDate"],
    lastChange: json["lastChange"],
    dealRating: json["dealRating"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "dealID": dealId,
    "salePrice": salePrice,
    "normalPrice": normalPrice,
    "savings": savings,
    "releaseDate": releaseDate,
    "lastChange": lastChange,
    "dealRating": dealRating,
    "thumb": thumb,
  };
}
