import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/config/style.dart';
 

class steamSaleCountdown extends StatelessWidget {
  const steamSaleCountdown({
    Key? key,
  }) : super(key: key);

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