import 'package:flutter/material.dart';
import 'package:hud/components/followPageItem.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';  // Might not be necessary to import
import 'package:http/http.dart' as http;
import 'package:hud/models/genreModel.dart';
import 'package:like_button/like_button.dart';


class FollowGenreList extends StatefulWidget {
  const FollowGenreList({Key? key}) : super(key: key);

  @override
  State<FollowGenreList> createState() => _FollowGenreListState();
}

class _FollowGenreListState extends State<FollowGenreList> {
  Future<GenreModel>? _genreModel;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Genres');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  bool isLoading = false;
  var currentFocus;

  @override
  void initState() {
    _genreModel = API_Manager().getGenres('Indie');
    super.initState();
  }

  void callGenres(String input){
    _genreModel = API_Manager().getGenres(input);
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
      ),

      body: Container(
        child: FutureBuilder<GenreModel>(
          future: _genreModel,

          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              isLoading = false;
              return ListView.builder(
                  itemCount: snapshot.data.results.length,

                  itemBuilder: (context, index) {
                    var genre = snapshot.data.results[index];  // This is responsible for going through the querried items from the API

                    return followPageItem(genre, 'genre', context);

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
  Future<GenreModel> getGenres(String genreName) async {
    var client = http.Client();
    var genreModel;
    String baseURL = 'https://api.rawg.io/api/genres?';
    String searchParam = 'search=';
    String urlSearchTerms = genreName.trim().toLowerCase().replaceAll(' ','-');
    String pageSize = '&page_size=20';
    String apiKey = '&key=88457281eae8421b8395d12d3df566ad';
    String finalURL = '';

    if (genreName == ''){ //if theres no platform searched, just return a list of popular platforms, DOES NOT CURRENTLY WORK
      finalURL = baseURL + apiKey + pageSize;
    } else { //otherwise attempt the search
      finalURL = baseURL + searchParam + urlSearchTerms + apiKey + pageSize;
    }

    print(finalURL);
    var uri = Uri.parse(finalURL);

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      var jsonMap = jsonDecode(json);

      genreModel = GenreModel.fromJson(jsonMap);
    }
    return genreModel;
  }
}
