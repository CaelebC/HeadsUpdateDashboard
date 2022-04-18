import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatelessWidget {
  // final String title;
  // final String selectedUrl;

  late WebViewController _controller;

  // MyWebView({
  //   @required this.title,
  //   @required this.selectedUrl,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("titlehere"),
      ),
      
      body: WebView(
        initialUrl: "https://steamdb.info/sales/history/",
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}