import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Bottomsheetform extends StatefulWidget {
  final String time;
  String currSource;
  String currDest;
  final List<String> source;
  final List<String> destination;

  Bottomsheetform({
    this.time,
    this.source,
    this.destination,
    this.currSource,
    this.currDest,
  });

  @override
  _BottomsheetformState createState() => _BottomsheetformState();
}

class _BottomsheetformState extends State<Bottomsheetform> {

  @override
  Widget build(BuildContext context) {

  String currentSource = widget.currSource;
  String currentDestination = widget.currDest;

    return Container(
      // TO DO --> style this container
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(widget.time),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // TO DO --> check for state changing logic and Validation

                // DropDown Menu for Source
                DropdownButton(
                  value: currentSource,
                  items: widget.source.map((_sources) {
                    return DropdownMenuItem(
                      value: _sources,
                      child: Text(_sources),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this.widget.currSource = newValueSelected;
                    });
                  },
                ),

                // DropDown Menu for Destination
                DropdownButton(
                  value: currentDestination,
                  items: widget.destination.map((_destinations) {
                    return DropdownMenuItem(
                      value: _destinations,
                      child: Text(_destinations),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this.widget.currDest = newValueSelected;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          FlatButton(
            color: Hexcolor('#083b66'),
            onPressed: () {
              Navigator.pushNamed(context, '/seatselect');
            },
            child: Text(
              "Proceed",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
