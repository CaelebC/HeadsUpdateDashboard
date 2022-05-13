import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';

import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:hud/models/gameModel.dart';
import 'package:like_button/like_button.dart';


Widget customNavigationButton (bText, bIcon, bFunc, BuildContext context){
  return SizedBox.fromSize(
    size: Size(180, 100),
    child: ClipRect(
      child: Material(
        color: accentColor,
        child: InkWell(
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => bFunc));},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(bIcon, color: textColor, size: 36,),
              SizedBox(height: 4.0),
              Text(bText, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            ]
          )
        )
      )
    )

  );
}
