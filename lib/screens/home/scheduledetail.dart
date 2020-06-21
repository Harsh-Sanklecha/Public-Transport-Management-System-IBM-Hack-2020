import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/transactions/bottomsheetform.dart';
import 'package:hexcolor/hexcolor.dart';

class Scheduledetail extends StatefulWidget {
  final DocumentSnapshot schedule;
  Scheduledetail({this.schedule});

  @override
  _ScheduledetailState createState() => _ScheduledetailState();
}

class _ScheduledetailState extends State<Scheduledetail> {
  List<String> _source;
  List<String> _destination;
  String currentSource;
  String currentDestination;
  String busNo;
  String route;

  @override
  Widget build(BuildContext context) {
    // Bottom Sheet with source and destination details
    void _showSettingsPanel(String time) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            var _sourceTemp = widget.schedule.data['source'].toList();
            _source = List<String>.from(_sourceTemp);
            var _destTemp = widget.schedule.data['destination'];
            _destination = List<String>.from(_destTemp);

            currentSource = _source[0];
            currentDestination = _destination[0];

            return Bottomsheetform(
              time: time,
              source: _source,
              destination: _destination,
              currSource: currentSource,
              currDest: currentDestination,
            );
          });
    }

    // Card widget class

    Card _buildCard(String time) {
      return Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            _showSettingsPanel(time);
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
    var time;
    var list = widget.schedule.data['time-seats'].keys;

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
                    for (time in list) _buildCard(time),
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
