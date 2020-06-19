import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Scheduledetail extends StatefulWidget {
  final DocumentSnapshot schedule;
  Scheduledetail({this.schedule});

  @override
  _ScheduledetailState createState() => _ScheduledetailState();
}

class _ScheduledetailState extends State<Scheduledetail> {
  var _source = ['SEC', 'PATNY', 'BATA', 'BH', '...'];
  var _destination = ['SEC', 'PATNY', 'BATA', 'BH', '...'];
  var currentSource = 'SEC';
  var currentDestination = 'SEC';
  String busNo;
  String route;

  @override
  Widget build(BuildContext context) {
    // Bottom Sheet with source and destination details
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              // TO DO --> style this container

              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // TO DO --> check for state changing logic and Validation

                        // DropDown Menu for Source
                        DropdownButton<String>(
                          items: _source.map((String dropdownSource) {
                            return DropdownMenuItem<String>(
                              value: dropdownSource,
                              child: Text(dropdownSource),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this.currentSource = newValueSelected;
                            });
                          },
                          value: currentSource,
                        ),
                        // DropDown Menu for Destination
                        DropdownButton<String>(
                          items: _destination.map((String dropDownDestination) {
                            return DropdownMenuItem<String>(
                              value: dropDownDestination,
                              child: Text(dropDownDestination),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this.currentDestination = newValueSelected;
                            });
                          },
                          value: currentDestination,
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
          });
    }

    // Card widget class

    Card _buildCard(String time) {
      return Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            _showSettingsPanel();
          },
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                color: Colors.greenAccent[700],
              ),
            ),
          ),
        ),
      );
    }

    busNo = widget.schedule.data['bus-no'];
    route = widget.schedule.data['route'];
  

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Hexcolor('#083b66'),
        title: Text(
          "Schedule for $busNo",
          style: TextStyle(
            fontFamily: 'cabin',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Timestamp
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Text(
                  "TODAY",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'cabin',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Route - $route",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 17.0,
                    fontFamily: 'cabin',
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: 10.0),
              // Grid View for each time interval
              Expanded(
                child: GridView.count(
                  childAspectRatio: 2,
                  crossAxisCount: 4,
                  children: <Widget>[
                    // Card For each time interval
                    _buildCard("10:00"),
                    _buildCard("11:00"),
                    _buildCard("12:00"),
                    _buildCard("13:00"),
                    _buildCard("14:00"),
                    _buildCard("15:00"),
                    _buildCard("16:00"),
                    _buildCard("17:00"),
                    _buildCard("18:00"),
                    _buildCard("19:00"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
