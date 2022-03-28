import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';  // Might not be necessary to import
import 'package:http/http.dart' as http;
import 'package:hud/models/newsModel.dart';


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
  bool isLoading = false;
  var currentFocus;

  @override
  void initState() {
    //TODO: replace this initial _newsmodel. when loading page, initial search param is 'q=' plus follow game names (each separated by the || OR operator,  abd formatted to replace spaces with '-'
    _newsModel = API_Manager().getNews('');
    super.initState();
  }

  void callNews(String input){
    _newsModel = API_Manager().getNews(input);
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
                          onSubmitted: (String value) { callNews(value);
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
          ]
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
                    //TODO: turn each list item into a button, on press tries to open articles.url in the default browser! (with appropriate popup)
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
                                  news.urlToImage,
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
                                    news.title,
                                    // overflow: TextOverflow.ellipsis,  // This is to make the 2nd line of the name turned into ... instead of showing everything. Commented it out for now since it looks ugly.
                                    //TODO: add article description to this list preview using news.description
                                    style: TextStyle(
                                      fontSize: 14,
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
  Future<NewsModel> getNews(String searchTerm) async {
    var client = http.Client();
    var newsModel;
    // https://newsapi.org/v2/everything?q=elden-ring&apiKey=d4baf1f0866e4cf4931479d8dedfadf1
    String baseURL = 'https://newsapi.org/v2/everything?';
    String searchParam = 'q=';
    String urlSearchTerms = searchTerm.trim().toLowerCase().replaceAll(' ','-');
    String pageSize = '&page_size=10';
    String apiKey = '&apiKey=d4baf1f0866e4cf4931479d8dedfadf1';
    String otherParams = '&searchIn=title,content';
    String finalURL = '';

    if (searchTerm == ''){ //if theres no game searched, just return a list of popular games, DOES NOT CURRENTLY WORK
      //TODO: replace the empty/default news search with follow list based one. if follow list is empty, change default search to news from common gaming sites like polygon, ign, kotaku, etc.
      finalURL = baseURL + searchParam  + 'elden-ring' + otherParams + apiKey + pageSize;
    } else { //otherwise attempt the search
      finalURL = baseURL + searchParam + urlSearchTerms + otherParams+ apiKey + pageSize;
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
