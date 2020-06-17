import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authentication/authentication.dart';
import 'package:flutterapp/screens/authentication/logic.dart';
import 'package:flutterapp/screens/authentication/login.dart';
import 'package:flutterapp/screens/authentication/signup.dart';
import 'package:flutterapp/screens/home/busview.dart';
import 'package:flutterapp/screens/home/scheduledetail.dart';
import 'package:flutterapp/screens/home/seatselect.dart';
import 'package:flutterapp/screens/home/settings.dart';
import 'package:flutterapp/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Stream Provider package to check for auth changes and pass to wrapper()
    
     return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          '/auth': (context) => Authenticate(),
          '/signup': (context) => Signup(),
          '/login': (context) => Login(),
          '/settings': (context) => Settings(),
          '/busview': (context) => BusView(), // to be removed later
          '/schedule': (context) => Scheduledetail(),
          '/seatselect': (context) => SeatSelect(),
        },
      ),
    );
  }
}
