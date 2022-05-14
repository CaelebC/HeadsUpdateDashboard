import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:like_button/like_button.dart';
import 'package:hud/components/followPageItem.dart';
import 'package:hud/components/followedTopicItem.dart';

import 'package:hud/models/gameModel.dart';
import 'package:hud/models/genreModel.dart';
import 'package:hud/models/platformModel.dart';
import 'package:hud/models/publisherModel.dart';
import 'package:hud/models/storeModel.dart';

import 'package:hud/db/gameDB.dart';
import 'package:hud/db/genreDB.dart';
import 'package:hud/db/platformDB.dart';
import 'package:hud/db/publisherDB.dart';
import 'package:hud/db/storeDB.dart';

class FollowMyList extends StatefulWidget {
  const FollowMyList({ Key? key }) : super(key: key);

  @override
  State<FollowMyList> createState() => _FollowMyListState();
}

class _FollowMyListState extends State<FollowMyList> {
  Future<List<String>>? _myListItem;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Games');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  bool isLoading = false;
  var currentFocus;
  var favoriteStatusIcon = Icons.favorite_border;
  bool isSelected = false;
  
  // This funtion is to put all of the names of the items into an array for the UI to use
  Future<List<String>> searchForAllResults() async {
    final games = await FollowedGames.instance.readAllResults();
    final genres = await FollowedGenres.instance.readAllFollowed();
    final platforms = await FollowedPlatforms.instance.readAllFollowed();
    final publishers = await FollowedPublishers.instance.readAllFollowed();
    final stores = await FollowedStores.instance.readAllFollowed();

    List<String> itemNames = [];
    // GamesDB
    for (var game in games) {
      String temp = game.name!;
      itemNames.add(temp);
    }

    // Genres
    for (var genre in genres) {
      String temp = genre.name!;
      itemNames.add(temp);
    }

    // Platforms
    for (var platform in platforms) {
      String temp = platform.name!;
      itemNames.add(temp);
    }

    // Publisher
    for (var publisher in publishers) {
      String temp = publisher.name!;
      itemNames.add(temp);
    }

    // Store
    for (var store in stores) {
      String temp = store.name!;
      itemNames.add(temp);
    }

    List<String> distinctSearchTerms = itemNames.toSet().toList();
    print(distinctSearchTerms);
    return distinctSearchTerms;
  }

  @override
  void initState() {
    _myListItem = searchForAllResults();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      
      appBar: AppBar(
        title: Text('Followed Topics'),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              }
            );
          },
        ),
        
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}
          )
        ]
      ),

      body: Container(
        child: FutureBuilder<List<String>>(
          future: _myListItem,
          
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              isLoading = false;
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  
                  itemBuilder: (context, index) {
                    var item = snapshot.data[index];  // This is responsible for going through the querried items from the API

                    return followedTopicItem(item, 'game', context);
                    
                  });
            
            } else
              return Center(child: CircularProgressIndicator());
          },

        ),

      ),
    );
  }
}