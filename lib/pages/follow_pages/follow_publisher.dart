import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

class FollowPublishers extends StatefulWidget {
  const FollowPublishers({ Key? key }) : super(key: key);

  @override
  State<FollowPublishers> createState() => _FollowPublishersState();
}

class _FollowPublishersState extends State<FollowPublishers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Text('FOLLOW PUBLISHERS PAGE'),
      ),
    );
  }
}