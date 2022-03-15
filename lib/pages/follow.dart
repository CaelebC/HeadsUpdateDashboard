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
      
      body: Container(
        child: FutureBuilder<GameModel>(
          future: _gameModel,
          
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.results.length,
                  
                  itemBuilder: (context, index) {
                    var game = snapshot.data.results[index];
                    
                    return Container(
                      height: 100,
                      margin: const EdgeInsets.all(8),
                      
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  game.backgroundImage,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          
                          SizedBox(width: 16),
                          
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children: <Widget>[
                                Text(
                                  game.name,
                                  
                                  overflow: TextOverflow.ellipsis,
                                  
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
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