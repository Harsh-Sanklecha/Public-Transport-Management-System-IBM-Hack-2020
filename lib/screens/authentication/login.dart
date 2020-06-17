import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


// TO DO --> To be removed

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
              height: 250.0,
              width: 500.0,
              color: Hexcolor('#083b66'),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70.0, 0, 0),
                  child: Container(
                    child: Text(
                      "Welcome Back ,",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'cabin-italic',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Log In!",
                    style: TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'lobster',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:150.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 20.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.phone_android),
                          labelText: 'PHONE NUMBER',
                          labelStyle: TextStyle(
                            fontFamily: 'cabin',
                            fontSize: 15.0,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal:15),
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    alignment: Alignment(0.0, 0.0),
                  ),
                  SizedBox(height: 10.0),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 45.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: (){},
                      child: Text(
                        "Send OTP",
                        style: TextStyle(
                          fontFamily: 'cabin',
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      color: Hexcolor('#083b66'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),  
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}