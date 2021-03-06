import 'dart:convert';
import 'dart:core';
import 'package:hud/components/followPageItem.dart';
import 'package:hud/config/style.dart';
import 'package:flutter/cupertino.dart';  // Might not be necessary to import
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hud/models/publisherModel.dart';
import 'package:like_button/like_button.dart';


class FollowPublisherList extends StatefulWidget {
  const FollowPublisherList({Key? key}) : super(key: key);

  @override
  State<FollowPublisherList> createState() => _FollowPublisherListState();
}

class _FollowPublisherListState extends State<FollowPublisherList> {
  Future<PublisherModel>? _publisherModel;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Publishers');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  bool isLoading = false;
  var currentFocus;

  @override
  void initState() {
    _publisherModel = API_Manager().getPublishers('');
    //TODO: fix: using the search param for publishers returns a different json format than without the search param, and causes and infinite load due to mismatched models.
    super.initState();
  }

  void callPlatforms(String input){
    _publisherModel = API_Manager().getPublishers(input);
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
                            hintText: 'ex. Devolver Digital',
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
                      customSearchBar = Text('Publishers');
                      customIcon = const Icon(Icons.search);
                    }
                  }
                  );},
                icon: customIcon)
          ]
      ),

      body: Container(
        child: FutureBuilder<PublisherModel>(
          future: _publisherModel,

          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              isLoading = false;
              return ListView.builder(
                  itemCount: snapshot.data.results.length,

                  itemBuilder: (context, index) {
                    var publisher = snapshot.data.results[index];  // This is responsible for going through the querried items from the API

                    return followPageItem(publisher, 'publisher', context, false);

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
  Future<PublisherModel> getPublishers(String publisherName) async {
    var client = http.Client();
    var publisherModel;
    String baseURL = 'https://api.rawg.io/api/publishers?';
    String searchParam = 'search=';
    String urlSearchTerms = publisherName.trim().toLowerCase().replaceAll(' ','-');
    String pageSize = '&page_size=10';
    String apiKey = '&key=88457281eae8421b8395d12d3df566ad';
    String finalURL = '';

    if (publisherName == ''){ //if theres no publisher searched, just return a list of popular publishers, DOES NOT CURRENTLY WORK
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

      publisherModel = PublisherModel.fromJson(jsonMap);
    }
    return publisherModel;
  }
}
