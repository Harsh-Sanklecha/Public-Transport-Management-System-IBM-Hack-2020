import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authentication/authentication.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:provider/provider.dart';


// This is wrapper which listens to auth changes ,i.e
// This checks if the user is logged in if yes,
// This returns home page else returns authentiate page

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}