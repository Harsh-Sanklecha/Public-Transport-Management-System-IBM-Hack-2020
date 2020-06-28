import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';


class TransactionStore {
  final String uid;
  final String username;
  final String time;
  final String source;
  final String destination;
  final String busNo;

  TransactionStore({
    this.username,
    this.uid,
    this.time,
    this.source,
    this.destination,
    this.busNo,
  });

  final Firestore db = Firestore.instance;
  var tID = new Random().nextInt(999999999-10000000);

  storingTransactions() {

    DocumentReference ref = db
      .collection('/user')
      .document(uid)
      .collection('transactions')
      .document(tID.toString());
    return ref.setData({
      'username' : username,
      'time': time,
      'source': source,
      'destination': destination,
      'BusNo': busNo,
      'TID': tID,
    }); 
  }

  int getID(){
    return tID;
  }
}
