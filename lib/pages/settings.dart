import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'package:hud/db/gameDB.dart';
import 'package:hud/db/genreDB.dart';
import 'package:hud/db/platformDB.dart';
import 'package:hud/db/publisherDB.dart';
import 'package:hud/db/storeDB.dart';

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
        child: clearDatabaseButton('Clear Followed Topics', context),
      )
    );
  }

}
