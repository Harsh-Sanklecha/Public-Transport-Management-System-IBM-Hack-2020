import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/screens/authentication/logic.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  String username;
  String uid;
  String profile;

  @override

  // TO DO --> Connect with firestore instead of firebase

  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      // print(Firestore.instance.collection('/user').document(user.uid).snapshots());
      setState(() {
        username = user.displayName;
        uid = user.uid;
        profile = user.photoUrl;
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: 'cabin',
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),

                  // Circular users image
                  // TO DO --> Add users image from firestore and build a default image function

                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(profile ??
                        'https://img.favpng.com/23/0/3/computer-icons-user-profile-clip-art-portable-network-graphics-png-favpng-YEj6NsJygkt6nFTNgiXg9fg9w.jpg'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 3.0),
                      //Username
                      child: Text(
                        username ?? 'user',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0),
                      //UID
                      child: Text("UID: $uid"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: MediaQuery.of(context).size.height * .50,
            child: ListView(
              // physics:  NeverScrollableScrollPhysics(), // List to be non-scrollable
              children: <Widget>[
                Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'transactionhistory');
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // TO-DO --> To convert into a class

                          Icon(Icons.credit_card),
                          Text("Transactions"),

                          // To remove all the empty containers and give proper styling
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.people),
                          Text("About Us"),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.headset_mic),
                          Text("Contact Us"),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () async {
                      await _auth.signOut();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.power_settings_new),
                          Text("Log Out"),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                      child: Text(
                    "App Version: 0.0.1 (beta)",
                    style: TextStyle(
                      fontFamily: 'cabin-italic',
                      color: Colors.grey[600],
                    ),
                  )),
                )
              ],
            ),
          ),
          FlatButton(
              color: Colors.grey[50],
              onPressed: () {
                Navigator.pushNamed(context, '/bluetooth');
              },
              child: Text(""))
        ],
      ),
    );
  }
}
