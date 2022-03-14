import 'package:flutter/material.dart';


Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];


class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Text('NEWS FEED PAGE'),
      ),

    );
  }
}

