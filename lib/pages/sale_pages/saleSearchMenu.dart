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
    sales = await API_Manager().searchSales(searchInputString);
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

            Container(
              height: 42,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: bgAccentColor,
                border: Border.all(color: Colors.black26),
              ),

              padding: const EdgeInsets.symmetric(horizontal: 8),
              
              child: TextField(
                controller: searchInputController,
                onSubmitted: (String value) {
                  searchInputString = value;
                  callSales();
                  unfocus();
                },
                decoration: InputDecoration(
                  hintText: 'ex. Prey',
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
            ),

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
}


class API_Manager {
  Future<List<SaleSearchModel>?> searchSales(String searchTerm) async {
    var client = http.Client();
    String initialURL = 'https://www.cheapshark.com/api/1.0/games?';
    String finalSearchTerm = searchTerm.trim().toLowerCase().replaceAll(' ','');
    String query = 'title=' + finalSearchTerm + '&';
    String otherParams = 'limit=60&exact=0';
    String finalURL = initialURL + query + otherParams;
    print(finalURL);
    var uri = Uri.parse(finalURL);

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return saleSearchModelFromJson(json);
    }
  }
}
