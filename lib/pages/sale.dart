import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/models/salesModel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/components/customTextIconButton.dart';
import 'package:http/http.dart' as http;
import 'package:hud/components/salesPageItem.dart';
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
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = Text('PC Game Sales');
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
    sales = await API_Manager().getSales();
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
        title: Text('Sales'),
        backgroundColor: primaryColor,
        centerTitle: true,
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
  Future<List<SalesModel>?> getSales() async {
    var client = http.Client();
    var uri = Uri.parse('https://www.cheapshark.com/api/1.0/deals?onSale=1');

    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return salesModelFromJson(json);
    }
  }
}
