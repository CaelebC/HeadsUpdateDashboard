import 'package:flutter/material.dart';
import 'package:hud/pages/loading.dart';
import 'package:hud/pages/news.dart';
import 'package:hud/pages/follow.dart';
import 'package:hud/pages/sale.dart';



void main() {
  runApp(MaterialApp(
    initialRoute: '/follow',

    routes: {
      // '/': (context) => Loading(),  // This is to load up APIs that the app might need at the start
      '/follow': (context) => FollowList(),
      // '/follow/user': (context) => FollowListUser(),
      // '/sale': (context) => Sale(),
      // '/settings': (context) => Settings(),
    },

  ));
}


