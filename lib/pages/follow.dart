import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';  // Might not be necessary to import
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hud/models/gameModel.dart';

Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];


class FollowList extends StatefulWidget {
  const FollowList({Key? key}) : super(key: key);

  @override
  State<FollowList> createState() => _FollowListState();
}

class _FollowListState extends State<FollowList> {
  Future<GameModel>? _gameModel;

  @override
  void initState() {
    _gameModel = API_Manager().getGames();
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      
      // appBar: AppBar(
      //   title: Text('Follow List'),
      //   backgroundColor: primaryColor,
      //   centerTitle: true,
      //   toolbarHeight: 40,
      //   titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      // ),

      body: Container(
        child: FutureBuilder<GameModel>(
          future: _gameModel,
          
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.results.length,
                  
                  itemBuilder: (context, index) {
                    var game = snapshot.data.results[index];  // This is responsible for going through the querried items from the API

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
                                  game.backgroundImage,
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
                                    game.name,
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
}

class API_Manager {
  Future<GameModel> getGames() async {
    var client = http.Client();
    var gameModel;
    var uri = Uri.parse('https://api.rawg.io/api/games?search=overcooked&key=88457281eae8421b8395d12d3df566ad&page_size=10');

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      var jsonMap = jsonDecode(json);

      gameModel = GameModel.fromJson(jsonMap);
    }
    return gameModel;
  }
}