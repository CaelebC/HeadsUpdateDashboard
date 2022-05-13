import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/models/salesModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/components/customNavigationButton.dart';
import 'package:http/http.dart' as http;
import 'package:hud/components/salesPageItem.dart';
import 'package:hud/models/saleSearchModel.dart';
import 'package:hud/pages/sale_pages/freeGames.dart';
import 'package:hud/pages/sale_pages/subPageSelection.dart';
import 'dart:core';


class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  List<SalesModel>? sales;
  List<SaleSearchModel>? saleResults;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('Sales');
  TextEditingController searchInputController = TextEditingController();
  String searchInputString = '';
  List<String> salesSortByOptions = ['Deal Rating', 'Title', 'Savings', 'Price', 'Release', 'Store', 'recent'];
  String? salesSortBy = 'Deal Rating';
  bool isLoaded = false;
  var currentFocus;


  @override
  void initState() {
    callSales();
    super.initState();
  }

  void callSales() async {
    sales = await API_Manager().getSales(salesSortBy);
    setState(() {
      isLoaded = true;
    });
    // isLoading = true;
    //Refresh or setstate() here to refresh the games list.
  }

  void callSearchSales() async{
    saleResults = await API_Manager().searchSales(searchInputString);
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

        leading: DropdownButton<String>(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            // isDense: true,
            isExpanded: true,
            icon: Icon(Icons.sort, color: textColor),
            iconSize: 26,

            items: salesSortByOptions.map((option) =>
                DropdownMenuItem<String>(
                  value: option,
                  child: Text(option, style: TextStyle(fontSize: 12)),
                )).toList(),

            onChanged: (option) {
              setState(() => salesSortBy = option);
              isLoaded = false;
              callSales();
            }
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
                        onSubmitted: (String value) {
                          searchInputString = value;
                          callSearchSales();
                          // TODO: PASS ^ THIS RESULTING CONTEXT TO THE SALESEARCH MENU PAGE TO LOAD THE RESULTS!
                          // TODO: WHEN SEARCH IS HIT, CREATE THAT PAGE WITH A FUTURE BUILDER AWAITING THOSE ASYNC RESULTS.
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
                    customSearchBar = Text('Sales');
                    customIcon = const Icon(Icons.search);
                  }
                }
                );},
              icon: customIcon
          )
        ],
      ),

      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: sales?.length,
          itemBuilder: (context, index){
            return salesPageItem(sales![index], context);
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SubSale()));},
        label: Text('Other Promotions'),
        icon: Icon(Icons.apps),
        backgroundColor: accentColor,
      ),

    );
  }
}


class API_Manager {
  Future<List<SalesModel>?> getSales(String? salesSearchBy) async {
    var client = http.Client();
    String initialURL = 'https://www.cheapshark.com/api/1.0/deals?onSale=1';
    String sortBy;
    if (salesSearchBy! == 'Deal Rating'){
      sortBy = '';
    } else {
      sortBy = '&sortBy=' + salesSearchBy!.toString().replaceAll(' ','');
    }
    //Strangely enough, the API "sorts" the query results by Deal Rating by default,
    //But adding the "sortBy=DealRating" parameter to the query actually flips
    //the results to sort from low to high. The above else-tree is meant to return
    //it to its original preferred behavior.

    String finalURL ='';
    finalURL = initialURL + sortBy;
    print(finalURL);
    var uri = Uri.parse(finalURL);

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return salesModelFromJson(json);
    }
  }

  Future<List<SaleSearchModel>?> searchSales(String saleSearchTerm) async {
    var client = http.Client();
    String initialURL = 'https://www.cheapshark.com/api/1.0/games?';
    String searchTerm = '&' + saleSearchTerm.trim().toLowerCase().replaceAll(' ','');
    String otherParams = '&limit=60&exact=0';
    String finalURL = initialURL + searchTerm + otherParams;
    print(finalURL);
    var uri = Uri.parse(finalURL);

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return saleSearchModelFromJson(json);
    }
  }
}
