import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(SeatSelect());

class SeatSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seats please!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Seats please!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  //String ab=("1","2","3","4","5");
  TextEditingController frase = TextEditingController();

  void _incrementCounter() {
    setState(() {
      count++;
      count = count < 20 ? count+0:0;
      frase.text = setPhrase();
    });
  }
  void _decrementCounter() {
    setState(() {
      count--;
      frase.text = setPhrase();
      count = count > 0 ? count+0:0;
    });
  }

  String setPhrase() {
    String msg;
    if(count < 0){
      msg = "Yep, you are probably doing something wrong.";
    }else if(count >= 0 && count < 9){
      msg = "Continue, we still have seats available!";
    }else if(count > 20){
      msg = "You have crossed the maximum limit";
    }
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Hexcolor('#083b66'),
        title: Text(
          "Tickets",
          style: TextStyle(
            fontFamily: 'cabin',
          ),
        ),
      ),

      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "assets/",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Select number of tickets:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '$count',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        frase.text != "" ? frase.text : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.center,
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
                    "Proceed to Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
            backgroundColor: Colors.blue,
          ),
          SizedBox(
            height: 250.0,
            width: 6.0,
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ],
      ),

    );
  }
}
