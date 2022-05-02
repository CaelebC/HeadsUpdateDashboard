import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/components/customTextIconButton.dart';
import 'package:hud/pages/sale_pages/freeGames.dart';
import 'dart:core';


class SubSale extends StatefulWidget {
  const SubSale({Key? key}) : super(key: key);

  @override
  State<SubSale> createState() => _SubSaleState();
}

class _SubSaleState extends State<SubSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        // title: Text('Sales'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),

      body: Center(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Free Games Button
            customTextIconButton(
              'Free Games', 
              Icons.redeem_outlined, 
              FreeGameList(),
              context
            ),

            // Steam Sale Countdown button
            customTextIconButton(
              'Steam Sale Countdown', 
              Icons.access_alarm_outlined, 
              SteamSaleCountdown(),
              context
            ),

          ],
        ),
      ),

    );
  }
}