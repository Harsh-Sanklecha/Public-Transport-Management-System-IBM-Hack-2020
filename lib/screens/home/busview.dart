import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BusView extends StatelessWidget {

// TO DO --> To be removed if not approved

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#01233f'),
      body: ListView(
        children: <Widget>[
          Padding(
           padding: const EdgeInsets.only(top: 10.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white,
                  onPressed: (){},
                  iconSize: 28.0,
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.white,
                  onPressed: () {},
                  iconSize: 28.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Text(
              "Bus Details",
              style: TextStyle(
                fontFamily: 'lobster',
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: MediaQuery.of(context).size.height * .85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(20.0)),
            ),

            // Listing Bus Numbers
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left:10.0,right: 10.0),
              child: ListView(
                children: <Widget>[
                  _cardBuilder('40','SEC - KOTI'),
                  _cardBuilder('8A','SEC - AFG'),
                  _cardBuilder('5K','SEC - MDP'),
                  _cardBuilder('40','SEC - KOTI'),
                  _cardBuilder('8A','SEC - AFG'),
                  _cardBuilder('5K','SEC - MDP'),
                  _cardBuilder('40','SEC - KOTI'),
                  _cardBuilder('8A','SEC - AFG'),
                  _cardBuilder('5K','SEC - MDP'),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}


//Widget class for each Card
Widget _cardBuilder(String busNo, String route){
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // CircleAvatar(
            //   backgroundColor: Hexcolor('#083b66'),
            //   radius: 25.0,
            //     child: Icon(
            //     Icons.tram,
            //     color: Colors.white,
            //     size: 30.0,
            //     ),
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "BUS NO: $busNo",
                  style: TextStyle(
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
            ButtonTheme(
              minWidth: 0,
              child: FlatButton(
                onPressed: (){},
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 30.0,
                  color: Hexcolor('#01233f'),
                  ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}