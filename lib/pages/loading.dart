import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Color? bgColor = Colors.grey[900];
Color? primaryColor = Colors.purple[900];


const spinkit = SpinKitDualRing(
    color: Colors.purple,  // This b*tch won't allow for any color with a [x00] beside it
    size: 50.0,
);

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupApp() async {  // Loads APIs
    Navigator.pushReplacementNamed(context, '/news', arguments: {

    });
  }

  @override
  void initState() {

    super.initState();
  }

  @override  // This build code is the stuff that will actually be shown on screen
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.grey[900],  // This will be the default BG color for all pages

        body: Center(
          child: spinkit,
        )

    );

  }
}