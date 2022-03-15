import 'package:flutter/material.dart';


Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];


class FollowList extends StatefulWidget {
  const FollowList({Key? key}) : super(key: key);

  @override
  State<FollowList> createState() => _FollowListState();
}

class _FollowListState extends State<FollowList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(child: Text('Home', style: TextStyle(fontSize: 64.0),)),

    );
  }
}
