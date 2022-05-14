import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'package:hud/db/gameDB.dart';
import 'package:hud/db/genreDB.dart';
import 'package:hud/db/platformDB.dart';
import 'package:hud/db/publisherDB.dart';
import 'package:hud/db/storeDB.dart';

Widget clearDatabaseButton (bText, BuildContext context){
  
  Future deleteAll() async {
    final games = await FollowedGames.instance.readAllResults();
    final genres = await FollowedGenres.instance.readAllFollowed();
    final platforms = await FollowedPlatforms.instance.readAllFollowed();
    final publishers = await FollowedPublishers.instance.readAllFollowed();
    final store = await FollowedStores.instance.readAllFollowed();
    
    // These for-loop is handling the deletion of every single item in the DBs
    
    // Games
    for(var i in games){
      await FollowedGames.instance.delete(i.name);
    }

    // Genres
    for(var i in genres){
      await FollowedGenres.instance.unfollow(i.name);
    }

    // Platforms
    for(var i in platforms){
      await FollowedPlatforms.instance.unfollow(i.name);
    }
    
    // Publishers
    for(var i in publishers){
      await FollowedPublishers.instance.unfollow(i.name);
    }

    // Store
    for(var i in store){
      await FollowedStores.instance.unfollow(i.name);
    }

    print('Deleted all DB contents.');
  }

  
  return SizedBox.fromSize(
    size: Size(160, 120),
    child: ClipRect(
      child: Material(
        color: accentColor,
        child: InkWell(
          onTap: () {deleteAll();},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.recycling, color: textColor, size: 50,),
              SizedBox(height: 4.0),
              Text(bText, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            ]
          )
        )
      )
    )

  );
}
