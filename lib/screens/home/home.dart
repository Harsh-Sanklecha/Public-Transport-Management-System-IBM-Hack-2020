import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/scheduledetail.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username;
  String busno;
  String busroute;
  Future _data;
  String data = '';
  bool _scanning = false;
  FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();

// Function to get data about bus from databse(Firestore)
  Future getBusDetails() async {
    var db = Firestore.instance;
    QuerySnapshot data = await db.collection("bus").getDocuments();
    return data.documents;
  }

// Navigator function to navigate to scheduledetail page
  navigateToSchedule(DocumentSnapshot schedule) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scheduledetail(
                  schedule: schedule,
                )));
  }

  @override

  // TO DO --> Connect with firestore instead of firebase

  void initState() {
    super.initState();
    _data = getBusDetails();
    FirebaseAuth.instance.currentUser().then((user) {
      // print(Firestore.instance.collection('/user').document(user.uid).snapshots());
      setState(() {
        username = user.displayName;
      });
    }).catchError((e) {
      print(e.toString());
    });

    // Prompting the user to turn on Bluetooth
    _bluetooth.devices.listen((device) {
      setState(() {
        data += device.name + ' (${device.address})\n';
      });
    });
    _bluetooth.scanStopped.listen((device) {
      setState(() {
        _scanning = false;
        data += 'scan stopped\n';
      });
    });
    _bluetooth.startScan(pairedDevices: false);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    //Bottom Sheet with bus details
    void _showSettingsPanel() {
      var queryResult = [];
      var tempSearchStore = [];

      initiateSearch(val) {
        if (val.length == 0) {
          setState(() {
            queryResult = [];
            tempSearchStore = [];
          });
        }
        var capitalizedValue =
            val.substring(0, 1).toString() + val.substring(1);

        if ((queryResult.length == 0) && (val.length == 1)) {
          Firestore.instance.collection('bus');
          Search().searchByName(val).then((QuerySnapshot docs) {
            for (int i = 0; i < docs.documents.length; i++) {
              queryResult.add(docs.documents[i].data);
            }
          });
        } else {
          tempSearchStore = [];
          queryResult.forEach((element) {
            if (element['bus-no'].startsWith(capitalizedValue)) {
              setState(() {
                tempSearchStore.add(element);
              });
            }
          });
        }
      }

      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 500.0,
              padding: EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: _data,
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Getting data..."),
                      );
                    } else {
                      //List Builder for showing lists
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              onChanged: (val) {
                                initiateSearch(val);
                              },
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    color: Colors.grey[600],
                                    icon: Icon(Icons.arrow_back),
                                    iconSize: 20.0,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(left: 25.0),
                                  hintText: 'Search By Bus',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(4.0))),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .46,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                busno = snapshot.data[index].data[
                                    'bus-no']; // getting bus number from firestore
                                busroute = snapshot.data[index].data[
                                    'route']; // getting bus route from firestore

                                return _Cardetails(
                                  busNo: busno,
                                  route: busroute,
                                  pressed: () {
                                    navigateToSchedule(snapshot.data[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            );
          });
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration:
                BoxDecoration(color: Colors.teal[600]), //TO DO --> Change Color
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
                      color: Colors.white,
                      fontSize: 60.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      username ??
                          "user", // If the user returns null it replaces the name with "user"
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 17),
                                blurRadius: 17,
                                spreadRadius: -23,
                                color: Colors.grey[700],
                              )
                            ],
                          ),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                _showSettingsPanel(); // On tap calls the function written globally before scaffold
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/bus.png', // Bus/Train/Metro SVG's
                                    height: 160.0,
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 17),
                                blurRadius: 17,
                                spreadRadius: -23,
                                color: Colors.grey[700],
                              )
                            ],
                          ),
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/busview');
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 17),
                                blurRadius: 17,
                                spreadRadius: -23,
                                color: Colors.grey[700],
                              )
                            ],
                          ),
                          child: Material(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
    );
  }
}

class Search {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('bus')
        .where('Searchkey', isEqualTo: searchField.substring(0, 1).toString())
        .getDocuments();
  }
}
