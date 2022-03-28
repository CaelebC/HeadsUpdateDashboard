import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

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
              onPressed: () {} 
            ),

            ElevatedButton(
              child: Text('Publishers'), 
              onPressed: () {} 
            ),

            ElevatedButton(
              child: Text('My List'), 
              onPressed: () {} 
            ),
          ],
        ),
    
    );
  }
}