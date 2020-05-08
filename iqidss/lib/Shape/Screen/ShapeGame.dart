import 'package:flutter/material.dart';
import 'package:iqidss/shape/Model/MockData.dart';
import 'package:iqidss/shape/Screen/GamePage.dart';


class ShapeGame extends StatefulWidget {
  @override
  _ShapeGame createState() => _ShapeGame();
}

class _ShapeGame extends State<ShapeGame> {
  MockData mockData = MockData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona, play Shape!'),
        backgroundColor: Colors.red[300],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/shape.gif',
            ),
            Text("\nRemember Me,\n Remember Shape \n",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 25,
                  color: Colors.black,
                )),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: RaisedButton(
                color: Colors.pink[300],
                textColor: Colors.white,
                padding: const EdgeInsets.all(15.0),
                child: Text("Play Now", style: TextStyle(fontSize: 25)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GamePage()),
                  );
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}