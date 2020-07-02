import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/screens/loading.dart';
import 'package:flutterapp/screens/services/userdata.dart';
import 'package:hexcolor/hexcolor.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool flag = false;
  bool loading = false;
  String tb = '';
  String name = '';
  String phoneNo = '+91';
  String smssent, temp, verificationId;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            body: Column(children: <Widget>[
              ClipPath(
                clipper:
                    BottomWaveClipper(), // Calling bezier curve function for wave effect
                child: Container(
                  height: 250.0,
                  width: 500.0,
                  color: Hexcolor('#083b66'),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 70.0, 0, 0),
                        child: Container(
                          child: Text(
                            "Hello There,",
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
                          "Sign Up!",
                          style: TextStyle(
                            fontSize: 50.0,
                            fontFamily: 'lobster',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Form(
                    // From Starts here
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 0, 30.0, 20.0),
                            child: TextFormField(
                              //Username text field
                              textCapitalization: TextCapitalization.words,
                              validator: (val) =>
                                  val.isEmpty ? 'Enter Full Name' : null,
                              onChanged: (val) {
                                setState(() {
                                  this.name = val;
                                });
                              },
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.person_outline),
                                labelText: 'FULL NAME',
                                labelStyle: TextStyle(
                                  fontFamily: 'cabin',
                                ),
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                border: new OutlineInputBorder(
                                  borderSide: new BorderSide(),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          alignment: Alignment(0.0, 0.0),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(30.0, 0, 30.0, 20.0),
                            child: TextFormField(
                              //Phone number field
                              validator: (val) =>
                                  val.length != 10 ? 'Invalid Number' : null,
                              onChanged: (val) {
                                setState(() {
                                  this.temp = val;
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.phone_android),
                                labelText: 'PHONE NUMBER',
                                labelStyle: TextStyle(
                                  fontFamily: 'cabin',
                                  fontSize: 15.0,
                                ),
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                                border: new OutlineInputBorder(
                                  borderSide: new BorderSide(),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          alignment: Alignment(0.0, 0.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Container(
                            // Toggle switch for T&C
                            child: Row(
                              children: <Widget>[
                                Transform.scale(
                                  scale: 0.9,
                                  child: Switch(
                                    value: flag,
                                    onChanged: (newval) {
                                      setState(() {
                                        flag = newval;
                                      });
                                    },
                                    activeColor: Hexcolor('#01233f'),
                                  ),
                                ),
                                Text(
                                  "I accept the policy and terms.",
                                  style: TextStyle(fontFamily: 'cabin-italic'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ButtonTheme(
                          minWidth: 200.0,
                          height: 45.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),

                            // Calling verify phone function for signing in with form validation
                            onPressed: () async {
                              if ((_formKey.currentState.validate()) & flag) {
                                phoneNo += temp;
                                verifyPhone();
                              }
                              if (!flag) {
                                setState(() {
                                  tb = 'Please accept policy and terms';
                                });
                              } else {
                                setState(() {
                                  tb = '';
                                });
                              }
                            },
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
                        SizedBox(height: 10.0),

                        // If the user does'nt accept T&C shows this container
                        Container(
                          child: Text(
                            tb,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          );
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    };
    final PhoneVerificationCompleted verifiedSuccess =
        (AuthCredential _auth) {};
    final PhoneVerificationFailed verifyFailed = (AuthException e) {
      print('${e.message}');
    };

    // Main logic for phone verification
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 30),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future<bool> smsCodeDialoge(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Provide OTP'),
          content: TextFormField(
            // Text field for OTP
            autofocus: true,
            obscureText: true,
            keyboardType: TextInputType.number,
            validator: (val) => val.length != 6 ? 'Invalid OTP' : null,
            onChanged: (val) {
              this.smssent = val;
            },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user == null) {
                      Navigator.of(context).pop();
                      signIn(
                          smssent); // Calling Signin fn for phone authentication
                    }
                  });
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Hexcolor("#01233f")),
                ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    //Signing in with phone authentication with saving the details in database (Firestore)
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.of(context).pop();
      var userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = name;
      user.user.updateProfile(userUpdateInfo);
      UserData(uid: user.user.uid)
          .storeUserData(user, context); // Storing in Firestore
    }).catchError((e) {
      print(e);
    });
  }
}

// Class for besier curve which gives wave shape cut for a container
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
