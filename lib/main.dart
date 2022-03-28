import 'package:flutter/material.dart';
import 'package:hud/pages/loading.dart';

// News Page
import 'package:hud/pages/news.dart';

// Follow pages
import 'package:hud/pages/follow_pages/follow_games.dart';
import 'package:hud/pages/follow_pages/follow_MyList.dart';
import 'package:hud/pages/follow_pages/follow_publishers.dart';
import 'package:hud/pages/follow_pages/follow_menu.dart';

// Sale Pages
import 'package:hud/pages/sale.dart';

// Misc. Imports
import 'package:hud/config/style.dart';
import 'package:hud/pages/settings.dart';
import 'package:hud/models/gameModel.dart';


void main() {
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
  int currentIndex = 0;
  final screens = [
    FollowMenu(),
    NewsFeed(),
    Sale(),
    Settings(),
  ];  // It really needs to be in the same order as the navbar or else things routing will be wrong

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
                icon: Icon(Icons.dashboard_customize_outlined, color: Colors.white54),
                activeIcon: Icon(Icons.dashboard_customize),
                label: 'Follow',
                backgroundColor: primaryColor,
              ),  // Follow List Icon

              BottomNavigationBarItem(
                icon: Icon(Icons.my_library_books_outlined, color: Colors.white54),
                activeIcon: Icon(Icons.my_library_books),
                label: 'News',
                backgroundColor: primaryColor,
              ),  // News Feed Icon

              BottomNavigationBarItem(
                icon: Icon(Icons.discount_outlined, color: Colors.white54),
                activeIcon: Icon(Icons.discount),
                label: 'Sale',
                backgroundColor: primaryColor,
              ),  // Sale Feed Icon

              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined, color: Colors.white54),
                activeIcon: Icon(Icons.settings),
                label: 'Settings',
                backgroundColor: primaryColor,
              ),  // Settings Icon

            ]
        )

    );
  }
}
