import 'package:flutter/material.dart';
import 'package:hud/config/style.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hud/pages/sale_pages/steamSaleCountdown.dart';
import 'package:hud/components/customTextIconButton.dart';
import 'package:hud/pages/sale_pages/freeGames.dart';
import 'dart:core';


class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        title: Text('Sales'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),

      body: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Free Games Button
          customTextIconButton(
            'Free Games', 
            Icons.redeem_outlined, 
            FreeGameList(),
            context
          ),

          SizedBox(width: 16.0),

          // Steam Sale Countdown button
          customTextIconButton(
            'Steam Sale Countdown', 
            Icons.access_alarm_outlined, 
            SteamSaleCountdown(),
            context
          ),

        ],
      ),

    );
  }
}
