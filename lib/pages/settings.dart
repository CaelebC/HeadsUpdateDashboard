import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'package:hud/db/gameDB.dart';
import 'package:hud/components/clearDatabaseButton.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      
      backgroundColor: bgColor,
      body: Center(
        child: clearDatabaseButton('Clear My List', deleteAll(), context),
      )
    );
  }

  Future deleteAll() async {
    final games = await FollowedGames.instance.readAllResults();
    for(var i in games){
      await FollowedGames.instance.delete(i.name);
    }
  }

}
