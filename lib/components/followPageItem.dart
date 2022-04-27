import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/gameModel.dart';
import 'package:like_button/like_button.dart';

// --------READ ME! READ ME!--------
// Currently makes errors because a lot of changes are needed for this to be re-useable.
// The whole FollowItem class will be commented out until it can be properly used in the follow_pages files
// This video can be used for reference: https://www.youtube.com/watch?v=jAxNZYX7mHM
// This as well, though I haven't watched this and it only has 1 like and 500 views: https://youtu.be/TQVzZZnYkTo 

Widget followPageItem (item, BuildContext context){
  return Container(
    height: 80,
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),  // Space between each list item

    child: Row(
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,

          // This changes the shape that the image is in
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          // This displays the image
          child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                item.backgroundImage,
                fit: BoxFit.cover,
              )),
        ),

        SizedBox(width: 8),  // Spacer between image and game title

        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            // Game Title
            children: <Widget>[
              Flexible(
                child: Text(
                  item.name,
                  // overflow: TextOverflow.ellipsis,  // This is to make the 2nd line of the name turned into ... instead of showing everything. Commented it out for now since it looks ugly.

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),

                ),

              ),

            ],

          ),

        ),

        // LikeButton is an imported package widget to make a like/follow button (duh)
        LikeButton(
          size: 24,
          isLiked: false,
          animationDuration: const Duration(milliseconds: 500),
          bubblesSize: 0,
        )

      ],

    ),

  );
}