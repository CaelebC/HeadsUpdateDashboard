import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

class FollowGenres extends StatefulWidget {
  const FollowGenres({ Key? key }) : super(key: key);

  @override
  State<FollowGenres> createState() => _FollowGenresState();
}

class _FollowGenresState extends State<FollowGenres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      
      appBar: AppBar(
        title: Text('Genres'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(context);
            }
          )
        ]
      ),

      body: Center(
        child: Text('FOLLOW GENRES PAGE'),
      ),
    );
  }
}