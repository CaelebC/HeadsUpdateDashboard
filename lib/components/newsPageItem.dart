import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/newsModel.dart';


Widget newsPageItem (news, BuildContext context){
  return InkWell(
    // InkWell is a widget that lets the whole widget be interactable (touched), essentially making whatever the widget holds a button.
    // This is where the links are opened using the 'url_launcher' package
    onTap: () {
      launch(news.url);
    },

    child: Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bgAccentColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3.0,
          ),
        ]
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image of each article
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                // TODO: The news page breaks if the article has a null urlToImage String! Need to add a placeholder image if null condition, if possible!
                image: NetworkImage(news.urlToImage),
                fit: BoxFit.cover
              )
            ),
          ),

          SizedBox(height: 8.0),

          // Text of each article
          Container(
            child: Text(
              news.title,
              style: listTextStyle
            ),
          ),

        ],
      ),
    )
  );
}