import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

class FollowPlatforms extends StatefulWidget {
  const FollowPlatforms({ Key? key }) : super(key: key);

  @override
  State<FollowPlatforms> createState() => _FollowPlatformsState();
}

class _FollowPlatformsState extends State<FollowPlatforms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      
      appBar: AppBar(
        title: Text('Platforms'),
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
        child: Text('FOLLOW PLATFORMS PAGE'),
      ),
    );
  }
}