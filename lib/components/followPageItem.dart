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
Future followGame(var game) async {
  await FollowedGames.instance.createResult(game);
}

Future searchForResult(var name) async {
  final game = await FollowedGames.instance.readResult(name);
  print(game.name);
}
Future searchForAllResults() async {
  final games = await FollowedGames.instance.readAllResults();
  print(games);
}

// // Game DB functions
// Future followGenre(var game) async {
//   await FollowedGenres.instance.createResult(game);
// }


Widget followPageItem (item, itemType, BuildContext context){

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
          animationDuration: const Duration(milliseconds: 500),
          bubblesSize: 0,
          onTap: (isSelected) async{
            print(item.name);
            
            switch(itemType){
              case "game": {
                followGame(item);
                searchForResult(item.name);
                print('game switch statement reached');
              }
              break;

              case "genre": {
                // followGame(item);
                // searchForResult(item.name);
                print('genre switch statement reached');
              }
              break;

              case "platform": {
                // followGame(item);
                // searchForResult(item.name);
                print('platform switch statement reached');
              }
              break;

              case "publisher": {
                // followGame(item);
                // searchForResult(item.name);
                print('publisher switch statement reached');
              }
              break;

              case "store": {
                // followGame(item);
                // searchForResult(item.name);
                print('store switch statement reached');
              }
              break;

              default: { print('INVALID CHOICE'); }
              break;
            }
            
            
            //searchForAllResults();
            return !isSelected;
          },
        )

      ],

    ),

  );
}