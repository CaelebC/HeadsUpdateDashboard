import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';


Widget clearDatabaseButton (bText, bFunc, BuildContext context){
  return SizedBox.fromSize(
    size: Size(140, 100),
    child: ClipRect(
      child: Material(
        color: accentColor,
        child: InkWell(
          onTap: () {bFunc;},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.recycling, color: textColor, size: 36,),
              SizedBox(height: 4.0),
              Text(bText, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
            ]
          )
        )
      )
    )

  );
}
