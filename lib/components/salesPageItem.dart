import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/newsModel.dart';


Widget salesPageItem (sale, BuildContext context){
  return InkWell(
    // InkWell is a widget that lets the whole widget be interactable (touched), essentially making whatever the widget holds a button.
    // This is where the links are opened using the 'url_launcher' package
      onTap: () {
        launch('https://www.cheapshark.com/redirect?dealID=' + sale.dealId);
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
                      image: NetworkImage(sale.thumb),
                      fit: BoxFit.cover
                  )
              ),
            ),

            SizedBox(height: 8.0),

            // Name of game
            Container(
              child: Text(
                  sale.title,
                  style: listTextStyle
              ),
            ),

            SizedBox(height: 8.0),

            //
            Container(
              child: Text(
                  'Original Price: \$' + sale.normalPrice,
                  style: listSubTextStyle
              ),
            ),

            //
            Container(
              child: Text(
                  'Sale Price: ' + sale.salePrice,
                  style: listSubTextStyle
              ),
            ),

            Container(
              child: Text(
                  sale.savings + '% discount',
                  style: listSubTextStyle
              ),
            ),

          ],
        ),
      )
  );
}