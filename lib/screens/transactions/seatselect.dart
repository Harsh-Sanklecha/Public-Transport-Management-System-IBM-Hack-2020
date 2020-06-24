import 'package:flutter/material.dart';

class SeatSelect extends StatefulWidget {
  @override
  _SeatSelectState createState() => _SeatSelectState();
}

class _SeatSelectState extends State<SeatSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Select Seat")),
        body: Padding(
          padding: const EdgeInsets.all(58.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                  crossAxisCount: 5,
                  children: <Widget>[
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    Container(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                    _buildFlatButton(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  FlatButton _buildFlatButton() {
    return FlatButton(
        child: Text(
          "",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        splashColor: Colors.green,
        highlightColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Colors.grey[400], width: 2.0),
        ),
        onPressed: () {
          setState(() {});
        });
  }
}
