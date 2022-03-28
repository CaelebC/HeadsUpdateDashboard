import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';  // Might not be necessary to import
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hud/models/platformModel.dart';

Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];


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
                          onSubmitted: (String value) { callPlatforms(value);
                          unfocus();
                          },
                          //then call setstate to refresh the games list!
                          decoration: InputDecoration(
                            hintText: 'ex. PC',
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
                      customSearchBar = Text('Platforms');
                      customIcon = const Icon(Icons.search);
                    }
                  }
                  );},
                icon: customIcon)
          ]
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
                                  platform.backgroundImage,
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
                                    platform.name,
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
  Future<PlatformModel> getPlatforms(String platformName) async {
    var client = http.Client();
    var platformModel;
    String baseURL = 'https://api.rawg.io/api/platforms?';
    String searchParam = 'search=';
    String urlSearchTerms = platformName.trim().toLowerCase().replaceAll(' ','-');
    String pageSize = '&page_size=10';
    String apiKey = '&key=88457281eae8421b8395d12d3df566ad';
    String finalURL = '';

    if (platformName == ''){ //if theres no platform searched, just return a list of popular platforms, DOES NOT CURRENTLY WORK
      finalURL = baseURL + apiKey + pageSize;
    } else { //otherwise attempt the search
      finalURL = baseURL + searchParam + urlSearchTerms + apiKey + pageSize;
    }

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
