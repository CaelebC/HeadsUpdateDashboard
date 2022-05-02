import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/components/steamSaleCountdown.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/components/steamSaleCountdown.dart';  // Call using steamSaleCountdown();
import 'package:hud/components/customTextIconButton.dart';


import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        title: Text('Sales'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),

      body: Row(
        children: [
          customTextIconButton('Free Games', Icon(Icons.access_alarm_outlined), context),
          IconButton(onPressed: () {}, icon: Icon(Icons.access_alarm_outlined) ),

          IconButton(onPressed: () {}, icon: Icon(Icons.redeem_outlined) ),
        ],
      ),

    );
  }
}
