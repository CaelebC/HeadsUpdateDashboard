import 'package:flutter/material.dart';
import 'package:hud/components/followPageItem.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';  // Might not be necessary to import
import 'package:http/http.dart' as http;
import 'package:hud/models/platformModel.dart';
import 'package:like_button/like_button.dart';


class FollowPlatformList extends StatefulWidget {
  const FollowPlatformList({Key? key}) : super(key: key);

  @override
  State<FollowPlatformList> createState() => _FollowPlatformListState();
}

class _FollowPlatformListState extends State<FollowPlatformList> {
  Future<PlatformModel>? _platformModel;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Platforms');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  bool isLoading = false;
  var currentFocus;

  @override
  void initState() {
    _platformModel = API_Manager().getPlatforms('PC');
    super.initState();
  }

  void callPlatforms(String input){
    _platformModel = API_Manager().getPlatforms(input);
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
        child: FutureBuilder<PlatformModel>(
          future: _platformModel,

          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              isLoading = false;
              return ListView.builder(
                  itemCount: snapshot.data.results.length,

                  itemBuilder: (context, index) {
                    var platform = snapshot.data.results[index];  // This is responsible for going through the querried items from the API

                    return followPageItem(platform, 'platform', context);

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
  Future<PlatformModel> getPlatforms(String platformName) async {
    var client = http.Client();
    var platformModel;
    String baseURL = 'https://api.rawg.io/api/platforms?';
    String searchParam = 'search=';
    String urlSearchTerms = platformName.trim().toLowerCase().replaceAll(' ','-');
    String pageSize = '&page_size=25';
    String apiKey = '&key=88457281eae8421b8395d12d3df566ad';
    String finalURL = '';

    if (platformName == ''){ //if theres no platform searched, just return a list of popular platforms, DOES NOT CURRENTLY WORK
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

      platformModel = PlatformModel.fromJson(jsonMap);
    }
    return platformModel;
  }
}
