import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/config/style.dart';
 

class SteamSaleCountdown extends StatelessWidget {
  const SteamSaleCountdown({
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
      
      body: WebView(
        initialUrl: 'https://steamdb.info/sales/history/',
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}