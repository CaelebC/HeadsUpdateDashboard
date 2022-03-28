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
      
      appBar: AppBar(
        title: Text('Publishers'),
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
        child: Text('FOLLOW PUBLISHERS PAGE'),
      ),
    );
  }
}