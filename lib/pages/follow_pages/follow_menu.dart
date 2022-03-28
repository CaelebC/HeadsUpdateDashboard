import 'package:flutter/material.dart';
import 'package:hud/config/palette.dart';

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
      body: Center(
        child: Text('FOLLOW MENU PAGE'),
      ),
    );
  }
}