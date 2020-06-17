import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authentication/authentication.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:flutterapp/screens/loading.dart';
import 'package:provider/provider.dart';


// This is wrapper which listens to auth changes ,i.e
// This checks if the user is logged in if yes,
// This returns home page else returns authentiate page

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool splash = false;
  @override

  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
        splash = true;
      });
    });
  }

  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
    if(user == null){
      return splash ? Authenticate() : Loading();
    }else{
      return Home();
    }
  }
}