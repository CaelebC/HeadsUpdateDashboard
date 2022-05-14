import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/newsModel.dart';


Widget freeGamePageItem (freegame, BuildContext context){
  var displayImage = freegame.image;

  if (displayImage == null){
    displayImage = 'https://github.com/CaelebC/HeadsUpdateDashboard/blob/main/asset/placeholder.png?raw=true';
  }
  
  return InkWell(
    // InkWell is a widget that lets the whole widget be interactable (touched), essentially making whatever the widget holds a button.
    // This is where the links are opened using the 'url_launcher' package
      onTap: () {
        launch(freegame.openGiveawayUrl);
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
            // Image of each game
            Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(displayImage),
                      fit: BoxFit.cover
                  )
              ),
            ),

            SizedBox(height: 8.0),

            // Name of game
            Container(
              child: Text(
                  freegame.title,
                  style: listTextStyle
              ),
            ),

            SizedBox(height: 8.0),

            // Platform of game
            Container(
              child: Text(
                  'Available on: ' + freegame.platforms,
                  style: listSubTextStyle
              ),
            ),

            // End date of free game
            Container(
              child: Text(
                  'Grab until: ' + freegame.endDate,
                  style: listSubTextStyle
              ),
            ),

          ],
        ),
      )
  );
}