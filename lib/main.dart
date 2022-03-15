import 'package:flutter/material.dart';
import 'package:hud/pages/loading.dart';
import 'package:hud/pages/news.dart';
import 'package:hud/pages/follow.dart';
import 'package:hud/pages/sale.dart';
import 'package:hud/pages/settings.dart';
import 'package:hud/models/gameModel.dart';


Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];


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
    FollowList(),
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
