import 'package:cloud_firestore/cloud_firestore.dart';

class Search{

  searchByName(String searchField){

    return Firestore.instance.collection('Client')
    .where('SearchKey', isEqualTo: searchField.substring(0,1).toUpperCase() )
    .getDocuments();
  }

}