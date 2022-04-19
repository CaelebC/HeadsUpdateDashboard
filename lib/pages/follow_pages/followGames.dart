import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/gameModel.dart';
import 'package:like_button/like_button.dart';

import 'package:hud/db/gameDB.dart';


class FollowGames extends StatefulWidget {
  const FollowGames({Key? key}) : super(key: key);

  @override
  State<FollowGames> createState() => _FollowGamesState();
}

class _FollowGamesState extends State<FollowGames> {
  Future<GameModel>? _gameModel;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Games');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  bool isLoading = false;
  var currentFocus;
  var favoriteStatusIcon = Icons.favorite_border;
  bool isSelected = false;


  @override
  void initState() {
    _gameModel = API_Manager().getGames('Halo');
    super.initState();
  }

  void callGames(String input){
    _gameModel = API_Manager().getGames(input);
    setState(() {

    });
    // isLoading = true;
    //Refresh or setstate() here to refresh the games list.
  }

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        title: customSearchBar,
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
              onPressed: (){
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = ListTile(
                      leading: Icon(
                        Icons.search,
                        color: textColor,
                        size: 28,
                      ),
                      title: TextField(
                        controller: searchInputController,
                        onSubmitted: (String value) { callGames(value);
                          unfocus();
                        },
                        //then call setstate to refresh the games list!
                        decoration: InputDecoration(
                          hintText: 'ex. Hades',
                          hintStyle: TextStyle(
                            color: unselectedColor,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    );
                  
                  } else if (customIcon.icon == Icons.cancel){
                      searchInputController.clear();
                      unfocus();
                      //return title to games, swap icon back to search
                      customSearchBar = Text('Games');
                      customIcon = const Icon(Icons.search);
                  }
                }
                );},
              icon: customIcon),
        ]
      ),

      body: Container(
        child: FutureBuilder<GameModel>(
          future: _gameModel,
          
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              isLoading = false;
              //TODO: add a follow button to the side of each list<game>, onPressed/onFollow: insert important data from that context into the database (i.e game.name, game.background image, etc.)
              return ListView.builder(
                  itemCount: snapshot.data.results.length,
                  
                  itemBuilder: (context, index) {
                    var game = snapshot.data.results[index];  // This is responsible for going through the querried items from the API

                    return Container(
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),  // Space between each list item
                      
                      child: Row(
                        children: <Widget>[
                          // Card widget displays the image
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
                                  game.backgroundImage,
                                  fit: BoxFit.cover,
                                )),   
                          ),
                          
                          // SizedBox widget acts as a spacer between image and game title
                          SizedBox(width: 8),
                          
                          // Flexible widget to print out game titles
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              // Game Title
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    game.name,                                    
                                    style: listTextStyle,
                                  ),

                                ),

                              ],
                            ),
                          ),

                          // LikeButton is an imported package widget to make a like/follow button (duh)
                          LikeButton(
                            size: 24,
                            isLiked: isSelected,
                            animationDuration: const Duration(milliseconds: 500),
                            bubblesSize: 0,
                            onTap: (isSelected) async{
                              print(game.name);
                              followGame(game);
                              //searchForResult(game.name);
                              //#TODO
                              return !isSelected;
                            },
                          )

                          // Follow button using IconButton
                          // IconButton(
                          //   color: accentColor,
                          //   icon: Icon(favoriteStatusIcon),
                          //   onPressed: () {
                          //     print(game.name);
                          //     // print(game.backgroundImage);
                          //     // for (var x in game.genres){
                          //     //   print(x.name);
                          //     // }
                          //     // for (var x in game.platforms){
                          //     //   print(x.platform.name);
                          //     // }
                          //     // for (var x in game.stores){
                          //     //   print(x.store.name);
                          //     // }
                          //     // print("-----spacer------");
                          //     // print(game);
                          //     // followGame(game);
                          //     setState( () {
                          //       isSelected = !isSelected;
                          //       favoriteStatusIcon = isSelected ? Icons.favorite : Icons.favorite_border;
                          //     });
                          //   },
                          // ),

                        ],

                      ),

                    );
                    
                  });
            
            } else
              return Center(child: CircularProgressIndicator());
          },

        ),

      ),

    );

  }

  Future followGame(var game) async {
    await FollowedGames.instance.createResult(game);
  }

  Future searchForResult(var gameName) async {
    await FollowedGames.instance.readAllResults();
  }
}

class API_Manager {
  Future<GameModel> getGames(String gameName) async {
    var client = http.Client();
    var gameModel;
    String baseURL = 'https://api.rawg.io/api/games?';
    String searchParam = 'search=';
    String urlSearchTerms = gameName.trim().toLowerCase().replaceAll(' ','-');
    String pageSize = '&page_size=10';
    String apiKey = '&key=88457281eae8421b8395d12d3df566ad';
    String finalURL = '';

    if (gameName == ''){ //if theres no game searched, just return a list of popular games, DOES NOT CURRENTLY WORK
      finalURL = baseURL + apiKey + pageSize;
    } else { //otherwise attempt the search
      finalURL = baseURL + searchParam + urlSearchTerms + apiKey + pageSize;
    }

    var uri = Uri.parse(finalURL);

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      var jsonMap = jsonDecode(json);

      gameModel = GameModel.fromJson(jsonMap);
    }
    return gameModel;
  }
}
