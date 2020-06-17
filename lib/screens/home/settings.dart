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

  @override

 // TO DO --> Connect with firestore instead of firebase

  void initState(){
    super.initState();
    FirebaseAuth.instance.currentUser().then((user){
      // print(Firestore.instance.collection('/user').document(user.uid).snapshots());
      setState(() {
        username = user.displayName;
        uid = user.uid;
      });

    }).catchError((e){
      print(e.toString());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
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
                    backgroundImage: NetworkImage('https://lh3.googleusercontent.com/-_myMbB-qcn4/Xjz18pQD6xI/AAAAAAAAKj0/FxKjEDmR23UpHBUMrCGGlB5X4XE8D8MIACEwYBhgLKtQDAL1OcqyB5BmmWWCPjwm4peqsMI59Xrep529fBLVC97E5jA2KN3tCnxw2r9zYP0ABD6ChHo7VjUndXDqmyTOTp1upkvAciSWCUbGnTU_7VHsljFFwHkk0azJDCPHwPgtlvQQuWFpSlAXhyh6oUvexPDoQ3xD85m3BTP7AkFkXk46IhUgAYUzRzodddcrNAnee7yRWGJ9n2TgnP9WOJT5diV3VzbqsnCZMRhiRbZErQCk31K97J9Tgmd4K_iQ2QjKZJ3JxBJQH7dBHp5D0bLzAzZIAdhdYmimbzi_fP707R8FW0Dgbuwf3NSkNp9ehTJ-NPKx5K8vObxWZvd6rzgjSb8P-N5oQmJI1Gh86SoqEXAc7hfgdRGMgnw0N8YWzgOyaB4r67txB5Ed9aNPt3OHDDpMJn_af-7zhda4joh-TAGazOWa1SbcHy5xE0CKiq-1x3AnY1WsfhJUzBCk6nPqsVdHtkp0usSxEsjYCGMYDGuEbHO1h8aQ3of7xZEFRu4uQ9QBkQ-Qxrzb-4vfE93ecQNOS7tWnaPjgTmhZakpP6T1n8xHKPTVaHuQrRwXltxmLI_er2nqzVZYprOeRjbMy6vbgDrpb2C0awORwZRpa9JEyXU6cMP27ovcF/w140-h140-p/2020-02-06.jpg'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 3.0),
                      //Username
                      child: Text(
                        username,
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
            height: MediaQuery.of(context).size.height-500,
            child: ListView(
              physics:  NeverScrollableScrollPhysics(), // List to be non-scrollable
              children: <Widget>[
                Card(
                  child: InkWell(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
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
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
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
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
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
                    onTap: ()async {
                      await _auth.signOut();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
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
                  child: Center(child: Text(
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
        ],
      ),
    );
  }
}