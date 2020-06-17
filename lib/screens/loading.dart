import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 300.0),
          child: Column(
              children: <Widget>[
                Image.asset('assets/logo.png'),
                SizedBox(height: 50.0),
                Container(
                  //Spinkit ring loader using plugin
                child: SpinKitRing(
                  color: Hexcolor("#083b66"),
                  size: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}