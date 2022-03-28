import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

class FollowMyList extends StatefulWidget {
  const FollowMyList({ Key? key }) : super(key: key);

  @override
  State<FollowMyList> createState() => _FollowMyListState();
}

class _FollowMyListState extends State<FollowMyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      
      appBar: AppBar(
        title: Text('My List'),
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
        child: Text('FOLLOW MY LIST PAGE'),
      ),
    );
  }
}