// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:iqidss/score_models/score.dart';
import 'package:iqidss/score_services/score_data_service.dart';

import '../../mainpage.dart';

class VegetableScore extends StatefulWidget {
  final int score, totalQuestion, index;
  final String compliments;

  VegetableScore(
      {this.score, this.totalQuestion, this.index, this.compliments});

  @override
  _VegetableScoreState createState() => _VegetableScoreState();
}

class _VegetableScoreState extends State<VegetableScore> {

  List<Score> scores = new List<Score>();
  final dataService = ScoreDataService();
  Future<List<Score>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = dataService.getScoreList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Score>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             scores = snapshot.data;

            scores[3].id = snapshot.data[3].id;
            scores[3].score = snapshot.data[3].score;

            scores[3].score = widget.score;
            dataService.updateScore(id: scores[3].id, score: scores[3].score);

            return _buildMainPage(context);
          }
          else
           return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetable Score'),
        backgroundColor: Colors.redAccent[100],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, size: 30.0),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  widget.compliments.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                new Image.asset(
                  'assets/main.gif',
                  height: 190,
                ),
                SizedBox(height: 16.0),
                new Text(
                  'Your Score',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Text(
                  '${scores[3].score}' +
                      ' / ' +
                      widget.totalQuestion.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                MaterialButton(
                  color: Colors.red[50],
                  textColor: Colors.red,
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Replay Quiz',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    side: BorderSide(color: Colors.red[100], width: 5.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )),
    );
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
