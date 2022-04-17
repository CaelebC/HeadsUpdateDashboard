import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/components/steamSaleCountdown.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      appBar: AppBar(
        title: Text('Steam Sale Countdown'),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: 'https://steamdb.info/sales/history/',
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}
