import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hud/pages/settings.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// News Page
import 'package:hud/pages/news.dart';

// Follow pages
import 'package:hud/pages/followMenu.dart';


// Sale Pages
import 'package:hud/pages/sale.dart';

// Database Imports
import 'package:hud/db/gameDB.dart';
import 'package:hud/db/genreDB.dart';
import 'package:hud/db/platformDB.dart';
import 'package:hud/db/publisherDB.dart';
import 'package:hud/db/storeDB.dart';

// Misc. Imports
import 'package:hud/config/style.dart';
import 'package:hud/pages/freeGames.dart';
import 'package:hud/pages/loading.dart';


void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // final database = openDatabase(
  //   join(await getDatabasesPath(), 'game_database.db'),
  // );

  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  
  runApp(MaterialApp(
    home: MainTemplate(),
  ));
}

class MainTemplate extends StatefulWidget {
  const MainTemplate({Key? key}) : super(key: key);

  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  // The 'screens' array needs to be in the same order as the navbar or else things routing will be wrong
  int currentIndex = 0;
  final screens = [
    FollowMenu(),
    NewsFeed(),
    Sale(),
    Settings(),
  ];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: bgColor,  // For some reason, this won't apply the bgColor to the scaffolds of the other pages. This had to be hardcoded to the other pages for now.
        body: screens[currentIndex],

        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),  // This is what allows pressing properly on navbar items
            iconSize: 30.0,

            items: [

              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_customize_outlined, color: unselectedColor),
                activeIcon: Icon(Icons.dashboard_customize),
                label: 'Follow',
                backgroundColor: primaryColor,
              ),  // Follow List Icon

              BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books_outlined, color: unselectedColor),
                activeIcon: Icon(Icons.my_library_books),
                label: 'News',
                backgroundColor: primaryColor,
              ),  // News Feed Icon

              BottomNavigationBarItem(
                icon: Icon(Icons.discount_outlined, color: unselectedColor),
                activeIcon: Icon(Icons.discount),
                label: 'Sale',
                backgroundColor: primaryColor,
              ),  // Sale Feed Icon

              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined, color: unselectedColor),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: primaryColor,
              ),  // Settings Icon

            ]
        )

    );
  }
}
