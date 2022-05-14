import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:like_button/like_button.dart';
import 'package:hud/components/followPageItem.dart';
import 'package:hud/components/myListItem.dart';

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
  
  Future<List<String>> searchForAllResults() async {
    final games = await FollowedGames.instance.readAllResults();
    List<String> gameNames = [];
      // For-loop to read through GameDB
      for (var game in games) {
        String temp = game.name!;
        // temp = temp.replaceAll(new RegExp(r'[^\w\s]+'),'');
        // temp = temp.trim().toLowerCase().replaceAll(' ','%20');
        gameNames.add(temp);
      }
      List<String> distinctGameNames = gameNames.toSet().toList();
    return distinctGameNames;
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
        title: Text('My List'),
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

                    return myListItem(item, 'game', context);
                    
                  });
            
            } else
              return Center(child: CircularProgressIndicator());
          },

        ),

      ),
    );
  }
}