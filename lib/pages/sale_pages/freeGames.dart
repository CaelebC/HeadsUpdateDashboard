import 'package:flutter/material.dart';
import 'package:hud/components/followPageItem.dart';
import 'package:hud/config/style.dart';


import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';  // Might not be necessary to import
import 'package:http/http.dart' as http;
import 'package:hud/models/freeGameModel.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:hud/components/freeGamePageItem.dart';


class FreeGameList extends StatefulWidget {
  const FreeGameList({Key? key}) : super(key: key);

  @override
  State<FreeGameList> createState() => _FreeGameListState();
}

class _FreeGameListState extends State<FreeGameList> {
  List<FreeGameModel>? freegames;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Currently Free Games');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  bool isLoaded = false;
  var currentFocus;

  @override
  void initState() {
    callFreeGames();
    super.initState();
  }

  void callFreeGames() async {
    freegames = await API_Manager().getFreeGames();
    setState(() {
      isLoaded = true;
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


      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: freegames?.length,
          itemBuilder: (context, index){
            return freeGamePageItem(freegames![index], context);
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class API_Manager {
  Future<List<FreeGameModel>?> getFreeGames() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.gamerpower.com/api/giveaways?type=game&platform=pc');

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return freeGameModelFromJson(json);
    }
  }
}
