import 'package:flutter/material.dart';
import 'package:iqidss/mainpage.dart';
import 'package:iqidss/score_models/score.dart';
import 'package:iqidss/score_services/score_data_service.dart';

import 'GamePage.dart';

class ScoreBoard extends StatefulWidget {
  final int finalscore;
  ScoreBoard(this.finalscore);

  @override
  _ScoreBoard createState() => _ScoreBoard();
}

class _ScoreBoard extends State<ScoreBoard> {

  List<Score> scores = new List<Score>();
  final dataService = ScoreDataService();
  Future<List<Score>> _futureData;

   @override
  void initState() {
    super.initState();
     _futureData = dataService.getScoreList();
  }

  Widget build(BuildContext context) {
    return FutureBuilder<List<Score>>(
        future:  _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            scores = snapshot.data;

            scores[2].id = snapshot.data[2].id;
            scores[2].score = snapshot.data[2].score;

            scores[2].score = widget.finalscore;
            dataService.updateScore(id: scores[2].id, score: scores[2].score);
            return _buildMainScreen(context);
          } else
            return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen(BuildContext context) {
     return Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: Text('Score'),
          backgroundColor: Colors.red[300],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (_) {
                    return MainPage();
                  }));
                }),
          ],
          automaticallyImplyLeading: false,
        ),
        body: Container(
            padding: const EdgeInsets.all(68.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/shapebg.gif"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: <Widget>[
              Text("Congratulations!",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Container(
                height: 150,
                child: Image.asset(
                  'assets/happycat.gif',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(height: 10.0),
              Text("Your Score:",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Text('${scores[2].score}',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              SizedBox(height: 10.0),
              SizedBox(
                height: 50,
                child: RaisedButton.icon(
                  color: Colors.pink[300],
                  textColor: Colors.white,
                  icon: Icon(Icons.keyboard_return),
                  label: Text("Replay",
                      style: TextStyle(fontSize: 18, letterSpacing: 3)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new GamePage()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.pink[100], width: 5.0),
                  ),
                ),
              ),
            ])));
  }

    Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching data in progress'),
          ],
        ),
      ),
    );
  }
}
