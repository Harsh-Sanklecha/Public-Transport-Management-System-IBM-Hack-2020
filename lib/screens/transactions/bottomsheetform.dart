import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Bottomsheetform extends StatefulWidget {
  final String time;
  String currSource;
  String currDest;
  final String busNo;
  final List<String> source;
  final List<String> destination;

  Bottomsheetform({
    this.time,
    this.source,
    this.destination,
    this.currSource,
    this.currDest,
    this.busNo,
  });
  @override
  _BottomsheetformState createState() => _BottomsheetformState();
}

class _BottomsheetformState extends State<Bottomsheetform> {

  @override
  Widget build(BuildContext context) {

  String currentSource = widget.currSource;
  String currentDestination = widget.currDest;
  var size = MediaQuery.of(context).size;
  

    return Container(
      height: size.height * .30,
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * .02),
            Text(
              "Time : ${widget.time}",
              style: TextStyle(
                fontSize: 18.0,
                color: Hexcolor('#01233f'),
              ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  // DropDown Menu for Source
                  DropdownButton(
                    elevation: 0,
                    value: currentSource,
                    // hint: Text("SOURCE"),
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
            ButtonTheme(
              height: 50.0,
              minWidth: double.infinity,
              child: FlatButton(
                color: Hexcolor('#083b66'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/transactioncomplete', arguments: {
                    'time': widget.time,
                    'source': widget.currSource,
                    'destination': widget.currDest,
                    'busNo': widget.busNo,
                  });
                },
                child: Text(
                  "Proceed",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'cabin',
                    fontSize: 17.0,
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
