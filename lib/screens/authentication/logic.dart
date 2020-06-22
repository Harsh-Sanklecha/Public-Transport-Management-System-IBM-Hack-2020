import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;


  //Auth change Stream
  Stream<FirebaseUser> get user{
    return _auth.onAuthStateChanged;
  }

// Function for loggin / Signing with google
  Future<bool> loginWithGoogle() async {
      try {
        GoogleSignIn _googleSignIn = GoogleSignIn();
        GoogleSignInAccount account = await _googleSignIn.signIn();
        if(account == null )
          return false;
        AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken,
        ));
        FirebaseUser user = res.user;
        updateUserData(user);
        if(user == null)
          return false;
        return true;
      } catch (e) {
        print(e.message);
        print("Error logging with google");
        return false;
      }
    }

// Updating user into the database (FireStore)
  Future updateUserData(FirebaseUser user) async {
      DocumentReference ref = _db.collection('/user').document(user.uid);
      return ref.setData({
        'uid': user.uid,
        'name': user.displayName,
        'profile': user.photoUrl,
      });
}

// Function for signing out  
  Future signOut() async{
    try{
      FirebaseAuth.instance.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}