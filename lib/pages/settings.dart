import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'package:hud/db/gameDB.dart';


class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: IconButton(
          icon: Icon(Icons.recycling_rounded, size: 69, color: textColor,),
          onPressed: () {
            deleteAll();
          }
        ),
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
