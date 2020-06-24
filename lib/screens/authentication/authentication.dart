import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authentication/logic.dart';
import 'package:flutterapp/screens/loading.dart';
import 'package:hexcolor/hexcolor.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {

  var size = MediaQuery.of(context).size;

    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.17),
            
            // Head Logo
            Transform.scale(
              scale: 1.2,
              child: Image.asset(
                'assets/logo.png',
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Hexcolor("#01233f"),
                    fontFamily: 'lobster',
                    fontSize: 50.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: Text(
                "It is easier to sign up now",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'cabin-italic',
                  fontSize: 15.0,
                ),
              ),
            ),
            SizedBox(height: 40.0),

            // Button for signing up with phone number
            ButtonTheme(
              height: 50.0,
              minWidth: 320.0,
              child: RaisedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/signup');
                },
                color: Hexcolor('#083b66'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 16.0),
                  child: Text(
                    "Sign Up using phone number",
                    style: TextStyle(
                      fontFamily: 'cabin',
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90.0),
              
              //Button for signing with up with google
              child: ButtonTheme(
                height: 45.0,
                child: OutlineButton(
                  highlightedBorderColor: Colors.grey[400],
                  onPressed: () async{
                    setState(() => loading = true,);
                   dynamic res = await _auth.loginWithGoogle(); // Calling loginwithgoogle fn from auth class
                   if(res == null){
                     setState(() => loading = false,);
                     print("Error logging in");
                   }
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    Image.asset(
                      'assets/google_icon.png',
                      height: 20.0,
                      width: 20.0,
                      ),
                    Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontFamily: 'cabin',
                        fontSize: 16.0,
                        color: Colors.black
                      ),
                    ),
                  ],),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Container(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(
                    fontFamily: 'cabin-italic',
                    fontSize: 15.0,
                  ),
                  ),
              ),
            ),
        ],),
      ),
    );
  }
}
