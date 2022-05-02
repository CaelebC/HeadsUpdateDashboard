import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/gameModel.dart';
import 'package:like_button/like_button.dart';


Widget customTextIconButton (bText, bIcon, bFunc, BuildContext context){
  return ElevatedButton.icon(
    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => bFunc));},
    icon: bIcon,
    label: Text(
      bText,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,)
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(accentColor),
    ),


  );
}
