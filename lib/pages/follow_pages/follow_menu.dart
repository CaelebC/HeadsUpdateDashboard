import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/pages/follow_pages/follow_games.dart';
// import 'package:hud/pages/follow_pages/follow_publishers.dart';
import 'package:hud/pages/follow_pages/followGenres.dart';
import 'package:hud/pages/follow_pages/followPlatforms.dart';
import 'package:hud/pages/follow_pages/followStores.dart';
import 'package:hud/pages/follow_pages/follow_MyList.dart';

// Declaring routes
const routeMenu = '/';
const routeGames = '/games';
const routePublishers = '/publishers';
const routeMyList = '/my_list';

Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];

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
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowGames())
                );
              } 
            ),

            ElevatedButton(
              child: Text('Publishers'), 
              onPressed: () {
                //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => FollowPublishers())
                //);
              } 
            ),

            ElevatedButton(
              child: Text('Genres'), 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowGenreList())
                );
              } 
            ),

            ElevatedButton(
              child: Text('Platforms'), 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowPlatformList())
                );
              } 
            ),

            ElevatedButton(
              child: Text('Stores'), 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowStoreList())
                );
              } 
            ),

            ElevatedButton(
              child: Text('My List'), 
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