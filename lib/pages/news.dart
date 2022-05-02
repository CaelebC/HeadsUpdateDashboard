import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/newsModel.dart';
import 'package:hud/components/newsPageItem.dart';

import 'package:hud/db/gameDB.dart';
import 'package:hud/db/genreDB.dart';
import 'package:hud/db/platformDB.dart';
import 'package:hud/db/publisherDB.dart';
import 'package:hud/db/storeDB.dart';


class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  Future<NewsModel>? _newsModel;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('News');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  String? newsSortBy = 'relevancy';
  List<String> newsSortByOptions = ['relevancy', 'popularity', 'publishedAt'];
  bool isLoading = false;
  var currentFocus;

  // Future<List<GameOutput>> refreshGames() async {
  //   List<GameOutput> games = await FollowedGames.instance.readAllResults();
  //   return games;
  // }

  @override
  void initState() {
    //TODO: replace this initial _newsmodel. when loading page, initial search param is 'q=' plus follow game names (each separated by the || OR operator,  abd formatted to replace spaces with '-'
    _newsModel = API_Manager().getNews('', newsSortBy);
    searchForAllResults();
    super.initState();
  }

  void callNews(){
    _newsModel = API_Manager().getNews(searchInputString, newsSortBy);
    print(searchInputString);
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

          actions: [
            IconButton(
                onPressed: (){
                  setState(() {
                    if (customIcon.icon == Icons.search) {
                      customIcon = const Icon(Icons.cancel);
                      customSearchBar = ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 28,
                        ),
                        title: TextField(
                          controller: searchInputController,
                          onSubmitted: (String value) {
                            searchInputString = value;
                            callNews();
                          unfocus();
                          },
                          //then call setstate to refresh the games list!
                          decoration: InputDecoration(
                            hintText: 'ex. Polygon',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else if (customIcon.icon == Icons.cancel){
                      searchInputController.clear();
                      unfocus();
                      //return title to games, swap icon back to search
                      customSearchBar = Text('News');
                      customIcon = const Icon(Icons.search);
                    }
                  }
                  );},
                icon: customIcon)
          ],
      ),

      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              isLoading = false;
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  // TODO: if data.articles.length == 0, return title: 'No articles found!'
                  itemBuilder: (context, index) {
                    var news = snapshot.data.articles[index];  // This is responsible for going through the querried items from the API
                    return newsPageItem(news, context);
                  });

            } else
              return Center(child: CircularProgressIndicator());
          },

        ),

      ),

    );

  }
}

Future<List<String>> searchForAllResults() async {
  final games = await FollowedGames.instance.readAllResults();
  List<String> gameNames = [];
    for (var game in games) {
      String temp = game.name!;
      temp = temp.replaceAll(new RegExp(r'[^\w\s]+'),'');
      temp = temp.trim().toLowerCase().replaceAll(' ','%20');
      gameNames.add(temp);
    }
    List<String> distinctGameNames = gameNames.toSet().toList();
  return distinctGameNames;
}


class API_Manager {
  Future<NewsModel> getNews(String searchTerm, String? newsSortBy) async {
    var client = http.Client();
    var newsModel;
    // https://newsapi.org/v2/everything?q=elden-ring&apiKey=d4baf1f0866e4cf4931479d8dedfadf1
    String baseURL = 'https://newsapi.org/v2/everything?';
    List<String> searchGameNames = await searchForAllResults();
    String searchGameNamesConcat = await searchGameNames.join(" ");
    print(searchGameNamesConcat);
    String searchParam = 'q=';
    String urlSearchTerms;
    // SAMPLE: https://newsapi.org/v2/everything?   q=hades%20AND%20halo    &apiKey=d4baf1f0866e4cf4931479d8dedfadf1
    String pageSize = '&page_size=20';
    String apiKey = '&apiKey=d4baf1f0866e4cf4931479d8dedfadf1';
    String languageParam = '&language=en';
    String newsSortParam = '&sortBy=' + newsSortBy!;
    String finalURL = '';

    if (searchTerm == ''){ //if theres no game searched, just return a list of popular games, DOES NOT CURRENTLY WORK
      //TODO: replace the empty/default news search with follow list based one. if follow list is empty, change default search to news from common gaming sites like polygon, ign, kotaku, etc.
      urlSearchTerms = searchGameNamesConcat.trim().toLowerCase().replaceAll(' ','%20OR%20');
        if (urlSearchTerms == '') {
          finalURL = baseURL + searchParam + 'overcooked' + languageParam +
              newsSortParam + apiKey + pageSize;
        } else {
          finalURL = baseURL + searchParam + urlSearchTerms + languageParam +
              newsSortParam + apiKey + pageSize;
        }
    } else { //otherwise attempt the search
      urlSearchTerms = searchTerm.trim().toLowerCase().replaceAll(' ','%20');
      finalURL = baseURL + searchParam + urlSearchTerms + languageParam + newsSortParam + apiKey + pageSize;
    }

    var uri = Uri.parse(finalURL);
    print(finalURL);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      print ('response ok!');
      var json = response.body;
      var jsonMap = jsonDecode(json);

      newsModel = NewsModel.fromJson(jsonMap);
      print(newsModel);
    }
    return newsModel;
  }
}
