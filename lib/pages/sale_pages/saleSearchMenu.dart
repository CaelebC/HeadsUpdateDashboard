import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/models/saleSearchModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/components/customNavigationButton.dart';
import 'package:http/http.dart' as http;
import 'package:hud/components/saleSearchPageItem.dart';
import 'package:hud/pages/sale_pages/freeGames.dart';
import 'package:hud/pages/sale_pages/subPageSelection.dart';
import 'dart:core';
import 'package:hud/components/searchWidget.dart';


class SaleSearch extends StatefulWidget {
  const SaleSearch({Key? key}) : super(key: key);

  @override
  State<SaleSearch> createState() => _SaleSearchState();
}

class _SaleSearchState extends State<SaleSearch> {
  List<SaleSearchModel>? sales;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Search Results');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  bool isLoaded = false;
  var currentFocus;


  @override
  void initState() {
    callSales();
    super.initState();
  }

  void callSales() async {
    sales = await API_Manager().searchSales();
    setState(() {
      isLoaded = true;
    });
    // isLoading = true;
    //Refresh or setstate() here to refresh the games list.
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        title: customSearchBar,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,

        // 'Back' button
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
        child: Column(
          children: [
            buildSearch(),
            
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: sales?.length,
                itemBuilder: (context, index){
                  return saleSearchPageItem(sales![index], context);
                },
              ),
            ),
          ],
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
    text: searchInputString,
    hintText: 'ex. Prey',
    onChanged: searchGame,
  );

  void searchGame(String searchInputString) {
    return print(searchInputString);
  }
  
}


class API_Manager {
  Future<List<SaleSearchModel>?> searchSales() async {
    var client = http.Client();
    String finalURL ='https://www.cheapshark.com/api/1.0/games?title=batman&limit=60&exact=0';
    print(finalURL);
    var uri = Uri.parse(finalURL);

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return saleSearchModelFromJson(json);
    }
  }
}
