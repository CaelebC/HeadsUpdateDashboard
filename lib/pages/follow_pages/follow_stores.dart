import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

class FollowStores extends StatefulWidget {
  const FollowStores({ Key? key }) : super(key: key);

  @override
  State<FollowStores> createState() => _FollowStoresState();
}

class _FollowStoresState extends State<FollowStores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      
      appBar: AppBar(
        title: Text('Stores'),
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
        child: Text('FOLLOW STORES PAGE'),
      ),
    );
  }
}