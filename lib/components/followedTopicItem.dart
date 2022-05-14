import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/gameModel.dart';
import 'package:like_button/like_button.dart';

import 'package:hud/db/gameDB.dart';
import 'package:hud/db/genreDB.dart';
import 'package:hud/db/platformDB.dart';
import 'package:hud/db/publisherDB.dart';
import 'package:hud/db/storeDB.dart';

// --------READ ME! READ ME!--------
// Currently makes errors because a lot of changes are needed for this to be re-useable.
// The whole FollowItem class will be commented out until it can be properly used in the follow_pages files
// This video can be used for reference: https://www.youtube.com/watch?v=jAxNZYX7mHM
// This as well, though I haven't watched this and it only has 1 like and 500 views: https://youtu.be/TQVzZZnYkTo


// Game DB functions
Future deleteGame(var item) async {
  final name = await FollowedGames.instance.delete(item);
}

// Genre DB functions
Future followGenre(var item) async {
  await FollowedGenres.instance.followGenre(item);
}

// Platform DB functions
Future followPlatform(var item) async {
  await FollowedPlatforms.instance.followPlatform(item);
}

// Publisher DB functions
Future followPublisher(var item) async {
  await FollowedPublishers.instance.followPublisher(item);
}

// Platform DB functions
Future followStore(var item) async {
  await FollowedStores.instance.followStore(item);
}


Widget followedTopicItem (item, itemType, BuildContext context){
  return Container(
    height: 80,
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),  // Space between each list item

    child: Row(
      children: <Widget>[
          // Spacer between image and game title

        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            // Game Title
            children: <Widget>[
              Flexible(
                child: Text(
                  item,
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
        IconButton(
          icon: Icon(Icons.do_disturb_rounded),
          color: Colors.redAccent,
          onPressed: () {deleteGame(item);}, 
        ),
        
        // LikeButton(
        //   size: 24,
        //   animationDuration: const Duration(milliseconds: 500),
        //   bubblesSize: 0,
        //   onTap: (isSelected) async{
        //     print(item);
        //     deleteGame(item);

        //     switch(itemType){
        //       case "game": {
        //         // deleteGame(item);
        //         print('game switch statement reached');
        //       }
        //       break;

        //       case "genre": {
        //         // followGenre(item);
        //         // searchForResult(item.name);
        //         print('genre switch statement reached');
        //       }
        //       break;

        //       case "platform": {
        //         // followPlatform(item);
        //         // searchForResult(item.name);
        //         print('platform switch statement reached');
        //       }
        //       break;

        //       case "publisher": {
        //         // followPublisher(item);
        //         // searchForResult(item.name);
        //         print('publisher switch statement reached');
        //       }
        //       break;

        //       case "store": {
        //         // followStore(item);
        //         // searchForResult(item.name);
        //         print('store switch statement reached');
        //       }
        //       break;

        //       default: { print('INVALID CHOICE'); }
        //       break;
        //     }


        //     //searchForAllResults();
        //     return !isSelected;
        //   },
        // )

      ],

    ),

  );
}
