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
      body: Center(
        child: Text('FOLLOW MY LIST PAGE'),
      ),
    );
  }
}