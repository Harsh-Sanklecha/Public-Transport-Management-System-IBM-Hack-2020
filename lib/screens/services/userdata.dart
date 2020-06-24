import 'package:cloud_firestore/cloud_firestore.dart';


// Custom class for storing user data in database(Firestore)

class UserData{

  final Firestore _db = Firestore.instance;

  final String uid;
  UserData({ this.uid });

  storeUserData(user,context){
    DocumentReference ref = _db.collection('/user').document(uid);
      return ref.setData({
        'uid': uid,
        'name': user.user.displayName,
      });
  }
}
