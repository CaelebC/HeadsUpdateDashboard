import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:hud/db/gameDB.dart';
import 'package:hud/db/genreDB.dart';
import 'package:hud/db/platformDB.dart';
import 'package:hud/db/publisherDB.dart';
import 'package:hud/db/storeDB.dart';


Future deleteItem(String item) async {
  final games = await FollowedGames.instance.readAllResults();
  final genres = await FollowedGenres.instance.readAllFollowed();
  final platforms = await FollowedPlatforms.instance.readAllFollowed();
  final publishers = await FollowedPublishers.instance.readAllFollowed();
  final stores = await FollowedStores.instance.readAllFollowed();

  // Game check
  for (var game in games) {
    String temp = game.name;
    
    if (item == temp){
      final name = await FollowedGames.instance.delete(item);
      break;
    }
  }

  // Genre check
  for (var genre in genres) {
    String temp = genre.name;
    
    if (item == temp){
      final name = await FollowedGenres.instance.unfollow(item);
      break;
    }
  }

  // Platforms check
  for (var platform in platforms) {
    String temp = platform.name;
    
    if (item == temp){
      final name = await FollowedPlatforms.instance.unfollow(item);
      break;
    }
  }

  // Publishers check
  for (var publisher in publishers) {
    String temp = publisher.name;
    
    if (item == temp){
      final name = await FollowedPublishers.instance.unfollow(item);
      break;
    }
  }

  // Store check
  for (var store in stores) {
    String temp = store.name;
    
    if (item == temp){
      final name = await FollowedStores.instance.unfollow(item);
      break;
    }
  }
}


Widget followedTopicItem (item, BuildContext context){
  return Container(
    height: 80,
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),  // Space between each list item

    child: Row(
      children: <Widget>[
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            // Item name
            children: <Widget>[
              Flexible(
                child: Text(
                  item,

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

        // Delete button
        IconButton(
          icon: Icon(Icons.do_disturb_rounded, size: 28),
          color: Colors.redAccent,
          onPressed: () {
            deleteItem(item);
          }, 
        ),
        
      ],

    ),

  );
}
