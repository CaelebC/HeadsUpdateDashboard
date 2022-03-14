import 'package:flutter/material.dart';


Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];
Color? accentColor = Colors.purple[700];


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
      body: Center(
        child: Text('SALE PAGE'),
      ),

    );
  }
}
