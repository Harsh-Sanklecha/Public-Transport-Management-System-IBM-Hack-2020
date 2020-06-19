import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/scheduledetail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String username;
  String busno;
  String busroute;
  Future _data;

// Function to get data about bus from databse(Firestore)
  Future getBusDetails() async{
    var db = Firestore.instance;
    QuerySnapshot data = await db.collection("bus").getDocuments();
    return data.documents;
  }

navigateToSchedule(DocumentSnapshot schedule){
  Navigator.push(context, MaterialPageRoute(builder: (context) => Scheduledetail(schedule: schedule,)));
}
  @override

  // TO DO --> Connect with firestore instead of firebase

  void initState(){
    super.initState();
    _data = getBusDetails();
    FirebaseAuth.instance.currentUser().then((user){
      // print(Firestore.instance.collection('/user').document(user.uid).snapshots());
      setState(() {
        username = user.displayName;
      });

    }).catchError((e){
      print(e.toString());
    });
  }

  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    //Bottom Sheet with bus details
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.all(8.0),
          
          child: FutureBuilder(
            future: _data,
            builder: (_,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: Text("Getting data..."),);
            }
            else{

              //List Builder for showing lists
              return ListView.builder( 
                itemCount: snapshot.data.length,
                itemBuilder: (_,index){

                  busno = snapshot.data[index].data['bus-no']; // getting bus number from firestore
                  busroute =snapshot.data[index].data['route']; // getting bus route from firestore

                  return _Cardetails(
                    busNo: busno,
                    route: busroute,
                    pressed: (){
                      navigateToSchedule(snapshot.data[index]);
                    },
                  );
                },
              );
            }
          }),
        );
      });
    }


    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(color: Colors.teal), //TO DO --> Change Color
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Row for Settings icon 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        iconSize: 28.0,
                      ),
                    ],
                  ),

                  // Welcome text 
                  Text(
                    "Welcome,",
                    style: TextStyle(
                      fontFamily: "lobster",
                      color:Colors.white,
                      fontSize: 60.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      username ?? "user", // If the user returns null it replaces the name with "user"
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 70.0),
                  
                  // Grid View for each of the transport
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[

                        // TO DO --> Convert into a class
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [BoxShadow(offset: Offset(0,17),
                                blurRadius: 17,
                                spreadRadius: -23,
                                color: Colors.grey[700],
                              )],
                            ),
                            child: Material(
                              child: InkWell(
                                onTap: (){
                                  _showSettingsPanel(); // On tap calls the function written globally before scaffold
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/bus.png', // Bus/Train/Metro SVG's
                                      height: 170.0,
                                      ),
                                    Text(
                                      "BUS SCHEDULES",
                                      style: TextStyle(
                                        fontFamily: 'cabin',
                                        fontWeight: FontWeight.w700,
                                      ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(offset: Offset(0,17),
                              blurRadius: 17,
                              spreadRadius: -23,
                              color: Colors.grey[700],
                            )],
                          ),
                          child: Material(
                            child: InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, '/busview');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/train.png',
                                    height: 120.0,
                                    ),
                                  Text(
                                    "TRAIN SCHEDULES",
                                    style: TextStyle(
                                      fontFamily: 'cabin',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17),
                            boxShadow: [BoxShadow(offset: Offset(0,17),
                              blurRadius: 17,
                              spreadRadius: -23,
                              color: Colors.grey[700],
                            )],
                          ),
                          child: Material(
                            child: InkWell(
                              onTap: (){},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/metro.png',
                                    height: 110.0,
                                    ),
                                  Text(
                                    "METRO SCHEDULES",
                                    style: TextStyle(
                                      fontFamily: 'cabin',
                                      fontWeight: FontWeight.w700,
                                    ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ), 
        ],
      ),
    );
  }
}


// Class For styling the cards in botyom sheet
// Creating a simple class for card which has 2 columns and rows 
// for bus-no, route and right arrow for user's guide(UX)

class _Cardetails extends StatelessWidget {
   final String route;
   final String busNo;
   final Function pressed;

  const _Cardetails({
    Key key,
    this.busNo,
    this.route,
    this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        child: InkWell(
          onTap: pressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      busNo,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontFamily: 'cabin',
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      "Route: $route",
                      style: TextStyle(
                        fontFamily: 'cabin',
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}