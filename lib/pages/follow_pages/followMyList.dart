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
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,

        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              }
            );
          },
        ),
        
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}
          )
        ]
      ),

      body: Center(
        child: Text('FOLLOW MY LIST PAGE'),
      ),
    );
  }
}