import 'package:cloud_firestore/cloud_firestore.dart';

class DecreasingNumberOfSeats {
  final String docID;
  DecreasingNumberOfSeats({this.docID});

  final Firestore db = Firestore.instance;

  decrement() {
    db.collection('bus').document(docID).updateData({
    });
  }

  specificseat(){
    
  }
}
