import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';


class TransactionComplete extends StatefulWidget {
  @override
  _TransactionCompleteState createState() => _TransactionCompleteState();
  
}
class _TransactionCompleteState extends State<TransactionComplete> {

  String username;  
  String uid; 
  String qrData ="tID";
  Map data = {};
   

  @override
    void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      // print(Firestore.instance.collection('/user').document(user.uid).snapshots());
      setState(() {
        username = user.displayName;
        uid = user.uid;
      });
    }).catchError((e) {
      print(e.toString());
    });

    Firestore.instance.collection('user').document(uid).collection('transaction').document().snapshots();
  }

  Widget build(BuildContext context) {

  data = ModalRoute.of(context).settings.arguments;
 

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FlutterTicketWidget(
          width: 350.0,
          height: 500.0,
          isCornerRounded: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 1.0, color: Colors.green),
                      ),
                      child: Center(
                        child: Text(
                          data['time'],
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          data['source'],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.pink,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            data['destination'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Bus Ticket',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    children: <Widget>[
                      ticketDetailsWidget(
                          'Passenger', username ?? 'user', 'Date', '24-12-2018'),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 35.0),
                        child: ticketDetailsWidget(
                            'Bus No.', data['busNo'], 'Time', data['time']),
                      ),
                    ],
                  ),
                ),
                 

                 Padding (
                  padding: const EdgeInsets.only(top: 40.0, left: 60.0, right: 60.0) ,
                      child:Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            QrImage(data:qrData),
                              SizedBox(height:10.0),
                                 Text("Data here"),
                                   SizedBox(
              height: 10.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              child:Text("Generate QR code"),
              onPressed: () { 

              },
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0),
                // side:BorderSide(colors:Colors.blue,width:3.0),
              ),
            ),
          ],
        ),
       ),
               // Padding(
                 // padding: const EdgeInsets.only(top: 60.0, left: 70.0, right: 30.0),
                  //child: Container(
                    //width: 150.0,
                    //height: 150.0,
                    //decoration: BoxDecoration(
                      //  image: DecorationImage(
                        //    image: AssetImage('assets/qr-code.png'),
                          //  fit: BoxFit.cover)),
                  //),
                //),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 75.0, right: 75.0),
                  child: Text(
                    '9824 0972 1742 1298',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}