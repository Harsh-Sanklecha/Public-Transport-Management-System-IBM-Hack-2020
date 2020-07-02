import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';

class TransactionHistory extends StatefulWidget {
  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  Future _data;
  String uid;

  Future getTransactionDetails() async {
    var db = Firestore.instance;
    QuerySnapshot data = await db
        .collection('/user')
        .document(uid)
        .collection('transactions')
        .getDocuments();
    print(uid);
    print(data.documents);
    return data.documents;
  }

  @override
  void initState() {
    super.initState();

    _data = getTransactionDetails();
    FirebaseAuth.instance.currentUser().then((user) {
      // print(Firestore.instance.collection('/user').document(user.uid).snapshots());
      setState(() {
        uid = user.uid;
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transactions",
          style: TextStyle(
            fontFamily: 'cabin',
            fontSize: 22.0,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: FutureBuilder(
                future: _data,
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Getting data..."),
                    );
                  } else {
                    return GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                      children: <Widget>[
                        buildFlutterTicketWidget(),
                        ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              print(snapshot.data.length);
                              return buildFlutterTicketWidget();
                            }),
                      ],
                    );
                  }
                }),
          )),
    );
  }

  FlutterTicketWidget buildFlutterTicketWidget() {
    return FlutterTicketWidget(
      width: 100.0,
      height: 100.0,
      color: Colors.teal[600],
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: RichText(
                text: TextSpan(
                    text: "Bus No - ",
                    style: TextStyle(
                        fontFamily: 'cabin',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: '8A',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.normal)),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: RichText(
                text: TextSpan(
                    text: "Route - ",
                    style: TextStyle(
                        fontFamily: 'cabin',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'SEC-PATNY',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.normal)),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: RichText(
                text: TextSpan(
                    text: "Date - ",
                    style: TextStyle(
                        fontFamily: 'cabin',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: '28-06-2020 (10:00 AM)',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.normal)),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45.0),
              child: RichText(
                text: TextSpan(
                    text: "ID - ",
                    style: TextStyle(
                        fontFamily: 'cabin',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: '86663234',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.normal)),
                    ]),
              ),
            ),
          ]),
    );
  }
}
