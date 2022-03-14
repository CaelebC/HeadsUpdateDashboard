import 'package:flutter/material.dart';


Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];

class FollowList extends StatefulWidget {
  const FollowList({Key? key}) : super(key: key);

  @override
  State<FollowList> createState() => _FollowListState();
}

class _FollowListState extends State<FollowList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: Center(child: Text('Home', style: TextStyle(fontSize: 64.0),)),

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined),
              activeIcon: Icon(Icons.my_library_books),
              label: 'News',
              backgroundColor: primaryColor,
            ),  // News Feed Icon

            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_customize_outlined),
              activeIcon: Icon(Icons.dashboard_customize),
              label: 'Follow',
              backgroundColor: primaryColor,
            ),  // Follow List Icon

            BottomNavigationBarItem(
              icon: Icon(Icons.discount_outlined),
              activeIcon: Icon(Icons.discount),
              label: 'Sale',
              backgroundColor: primaryColor,
            ),  // Sale Feed Icon

            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: primaryColor,
            ),  // Settings Icon

          ]
        )

      );
  }
}
