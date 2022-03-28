import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/pages/follow_pages/follow_games.dart';
import 'package:hud/pages/follow_pages/follow_publishers.dart';
import 'package:hud/pages/follow_pages/follow_genres.dart';
import 'package:hud/pages/follow_pages/follow_platforms.dart';
import 'package:hud/pages/follow_pages/follow_stores.dart';
import 'package:hud/pages/follow_pages/follow_MyList.dart';

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
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowPublishers())
                );
              } 
            ),

            ElevatedButton(
              child: Text('Genres'), 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowGenres())
                );
              } 
            ),

            ElevatedButton(
              child: Text('Platforms'), 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowPlatforms())
                );
              } 
            ),

            ElevatedButton(
              child: Text('Stores'), 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => FollowStores())
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