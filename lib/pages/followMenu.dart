import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'package:hud/pages/follow_pages/followGames.dart';
import 'package:hud/pages/follow_pages/followPublishers.dart';
import 'package:hud/pages/follow_pages/followGenres.dart';
import 'package:hud/pages/follow_pages/followPlatforms.dart';
import 'package:hud/pages/follow_pages/followStores.dart';
import 'package:hud/pages/follow_pages/followedTopics.dart';

// Declaring routes
const routeMenu = '/';
const routeGames = '/games';
const routePublishers = '/publishers';
const routeMyList = '/my_list';

class FollowMenu extends StatefulWidget {
  const FollowMenu({ Key? key }) : super(key: key);

  @override
  State<FollowMenu> createState() => _FollowMenuState();
}

class _FollowMenuState extends State<FollowMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,

        appBar: AppBar(
          title: Text('Menu'),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),

        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 80),

          children: [
            ElevatedButton(
              child: Text('Games'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentColor)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FollowGames())
                );
              }
            ),

            ElevatedButton(
              child: Text('Publishers'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentColor)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FollowPublisherList())
                );
              }
            ),

            // ElevatedButton(
            //   child: Text('Genres'),
            //   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentColor)),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => FollowGenreList())
            //     );
            //   }
            // ),

            ElevatedButton(
              child: Text('Platforms'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentColor)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FollowPlatformList())
                );
              }
            ),

            ElevatedButton(
              child: Text('Stores'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentColor)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FollowStoreList())
                );
              }
            ),

            ElevatedButton(
              child: Text('Followed Topics'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(accentColor)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FollowMyList())
                );
              }
            ),

          ],
        ),

    );
  }
}
